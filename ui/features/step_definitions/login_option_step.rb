Given(/^the user is registered and stay login$/) do |table|
  table_hash = {}
  table.rows.each do |key, value|
     table_hash[key] = value
  end
  @registration_table = table_hash

  @page_object = PageObjectLoginRelated.new(BROWSER)
    
  page_url = URLS + @page_object.homePage.page_url_value
  puts "****** The expect page url: #{page_url} ******"
  puts "****** The current page url: #{BROWSER.url} ******"

  begin
    WaitUtility.wait_untill_elements_size_steadied
    @page_object.menuBar.usernameMenu_element.text
  rescue Exception => e
    BROWSER.goto page_url
    @page_object.homePage.login_element.when_visible(TIME_OUT_LIMIT)
    @page_object.homePage.login_element.click
    WaitUtility.wait_untill_elements_size_steadied

    @page_object.loginPage.email_element.when_visible(TIME_OUT_LIMIT)

    @page_object.loginPage.email = table_hash["Email address"]
    @page_object.loginPage.password = table_hash["Password"]

    @page_object.loginPage.login_element.click
    WaitUtility.waitWhileSpinnerPresent(45)

    if @page_object.loginPage.loginError_element.visible?
      @page_object.loginPage.signUp_element.click

      @page_object.signUpPage.firstName_element.when_visible(TIME_OUT_LIMIT)
      WaitUtility.wait_untill_elements_size_steadied

      @page_object.signUpPage.firstName = table_hash["First name"]
      @page_object.signUpPage.lastName = table_hash["Last name"]
      @page_object.signUpPage.email = table_hash["Email address"]

      @page_object.signUpPage.birthMonth = table_hash["Birth Month"]
      @page_object.signUpPage.birthDay = table_hash["Birth Day"]
      @page_object.signUpPage.birthYear = table_hash["Birth Year"]

      @page_object.signUpPage.password = table_hash["Password"]
      @page_object.signUpPage.confirmPassword = table_hash["Confirm Password"]

      @page_object.signUpPage.tosCheckBox_element.click if table_hash["TOS CheckBox"].upcase == "TRUE"

      @page_object.signUpPage.signUp_element.click
    end
    WaitUtility.wait_untill_elements_size_steadied
  end
  # @page_object.homePage.favorites_element.when_visible(TIME_OUT_LIMIT)
end

