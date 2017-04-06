When(/^the save note button would be disabled$/) do
  WaitUtility.wait_untill_elements_size_steadied

  expect(@page_object.detailPage.saveNote_element.enabled?).to eq(false), "the save note button would be disabled"
end

When(/^the delete note button would be disabled$/) do
  WaitUtility.wait_untill_elements_size_steadied

  expect(@page_object.detailPage.saveNote_element.enabled?).to eq(false), "the save note button would be disabled"
end

Given(/^the user select a university$/) do
  WaitUtility.wait_untill_elements_size_steadied
  table = @page_object.searchSchoolsPage.searchResults_element
  table[1][0].click
end

When(/^the user select the university as favorite$/) do
  WaitUtility.wait_untill_elements_size_steadied
  table = @page_object.searchSchoolsPage.searchResults_element
  table[1][0].click

  WaitUtility.wait_untill_elements_size_steadied
  class_text = @page_object.detailPage.favoriteDetail_element.when_visible(TIME_OUT_LIMIT).attribute("class")
  @page_object.detailPage.favoriteDetail_element.when_visible(TIME_OUT_LIMIT).click if class_text.include? "outline"
end

When(/^the system should display asterisk for required field - title$/) do
  WaitUtility.wait_untill_elements_size_steadied
  fail "Write the code for - Display asterisk for required field"
end


When(/^the user add and save note\(s\)$/) do |table|
  i = 0
  x_i = table.rows.size
  table.rows.each do |key, value|
    i +=1
    @page_object.detailPage.titleNote = key
    @page_object.detailPage.bodyNote = value
    @page_object.detailPage.saveNote_element.when_visible(TIME_OUT_LIMIT).click
    
    @page_object.detailPage.addNote_element.when_visible(TIME_OUT_LIMIT).click unless i == x_i
    WaitUtility.wait_untill_elements_size_steadied
  end
end

When(/^the user add but did not save note$/) do |table|
  table.rows.each do |key, value|
    @page_object.detailPage.titleNote = key
    @page_object.detailPage.bodyNote = value
  end
end

When(/^the user select Notes from detail page$/) do
  WaitUtility.wait_untill_elements_size_steadied

  @page_object.detailPage.notes_element.when_visible(TIME_OUT_LIMIT).click
end

When(/^the user delete all existing note$/) do
  WaitUtility.wait_untill_elements_size_steadied
  next_delete = true
  while next_delete
    WaitUtility.wait_untill_elements_size_steadied
    @page_object.detailPage.delete_element.click
    @page_object.detailPage.yesDelete_element.click

    note_content = @page_object.detailPage.noteTable_element.when_visible(TIME_OUT_LIMIT).text

    next_delete = false if note_content.include? "New note"
  end
  
end

#display ------------------

Then(/^the system should be displayed below info\. under Notes section$/) do |table|
  WaitUtility.wait_untill_elements_size_steadied
  
  expect_data = []
  expect_data = table.rows.map{|x, y| x.strip}
  expect_data = expect_data + ["Title", "Content"]

  note_content = @page_object.detailPage.noteTable_element.when_visible(TIME_OUT_LIMIT).text
  note_content = note_content.split("\n")
  note_content = note_content.map{|x| x.strip}

  expect_results = expect_data - note_content
  got_results = note_content - expect_data
  
  expect(got_results).to eq(expect_results), "expected: #{expect_data}\n     got:#{note_content}\n   diff:\n#{expect_results}\n#{got_results}"
end

Then(/^the system should be displayed below title$/) do |table|
  WaitUtility.wait_untill_elements_size_steadied
  note_content = @page_object.detailPage.noteTable_element.when_visible(TIME_OUT_LIMIT).text
  
   table.rows.each do |key, v|
    expect(note_content.include? key).to eq(true), "It was looking for: #{key}\ngot: #{note_content}"
   end
end

Then(/^the user visit Academic page and return back$/) do
  WaitUtility.wait_untill_elements_size_steadied
  @page_object.detailPage.academic_element.when_visible(TIME_OUT_LIMIT).click
  WaitUtility.wait_untill_elements_size_steadied
  @page_object.detailPage.notes_element.when_visible(TIME_OUT_LIMIT).click
  WaitUtility.wait_untill_elements_size_steadied
end

Then(/^the user visit Description page and return back$/) do
  WaitUtility.wait_untill_elements_size_steadied
  @page_object.detailPage.description_element.when_visible(TIME_OUT_LIMIT).click
  WaitUtility.wait_untill_elements_size_steadied
  @page_object.detailPage.notes_element.when_visible(TIME_OUT_LIMIT).click
  WaitUtility.wait_untill_elements_size_steadied
end

Then(/^the system should displayed "([^"]*)" and "([^"]*)" under notes$/) do |title_note, body_note|
  expect(@page_object.detailPage.titleNote).to eq title_note
  expect(@page_object.detailPage.bodyNote).to eq body_note
end

Then(/^the user should loss the note data$/) do
  expect(@page_object.detailPage.titleNote).to eq ""
  expect(@page_object.detailPage.bodyNote).to eq ""
end

Given(/^the user A register and stay login$/) do |table|
  table_hash = {}
  table.rows.each do |key, value|
     table_hash[key] = value
  end
  @table = table_hash

  @page_object = PageObjectLoginRelated.new(BROWSER)
    
  page_url = URLS + @page_object.homePage.page_url_value
  puts "****** The expect page url: #{page_url} ******"
  puts "****** The current page url: #{BROWSER.url} ******"

  BROWSER.goto page_url

  begin
    WaitUtility.wait_untill_elements_size_steadied
    @page_object.menuBar.usernameMenu_element.text
  rescue Exception => e
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

