#New Profile ---------
Then(/^the user select Profile from drop down$/) do
  unless BROWSER.url.include? "profile"
    @page_object.loginDropDown.username_element.when_visible(TIME_OUT_LIMIT)
    @page_object.loginDropDown.username_element.click
    
    @page_object.loginDropDown.profile_element.when_visible(TIME_OUT_LIMIT)
    @page_object.loginDropDown.profile_element.click
  end 
end

Given(/^the user is registered with below information$/) do |table|
  table_hash = {}
  table.rows.each do |key, value|
     table_hash[key] = value
  end
  @registration_table = table_hash

  @page_object = PageObjectLoginRelated.new(BROWSER)
    
  page_url = URLS + @page_object.homePage.page_url_value
  puts "****** The expect page url: #{page_url} ******"
  puts "****** The current page url: #{BROWSER.url} ******"

  # BROWSER.goto page_url
 if (BROWSER.url.include? "sign") || (BROWSER.url.include? "login") || (BROWSER.url.include? "profile")
    @page_object.loginDropDown.username_element.when_visible(TIME_OUT_LIMIT).click

    @page_object.loginDropDown.logOut_element.when_visible(TIME_OUT_LIMIT).click
    BROWSER.goto URLS
  else
    BROWSER.goto page_url
  end

  @page_object.homePage.login_element.when_visible(TIME_OUT_LIMIT)
    
  @page_object.loginPage.signUp_element.click

  @page_object.signUpPage.firstName_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  @page_object.signUpPage.firstName = table_hash["First name"]
  @page_object.signUpPage.lastName = table_hash["Last name"]
  
  email_ext = 100000 + rand(999999)
  x_email = table_hash["Email address"].split("@")
  table_hash["Email address"] = x_email[0] + '-'+ email_ext.to_s + '@' + x_email[1]
  @registration_table["Email address"] = table_hash["Email address"]
  puts "Email address that user get registered: #{table_hash["Email address"]}"
  
  @page_object.signUpPage.email = table_hash["Email address"]

  @page_object.signUpPage.birthMonth = table_hash["Birth Month"]
  @page_object.signUpPage.birthDay = table_hash["Birth Day"]
  @page_object.signUpPage.birthYear = table_hash["Birth Year"]

  @page_object.signUpPage.password = table_hash["Password"]
  @page_object.signUpPage.confirmPassword = table_hash["Confirm Password"]

  @page_object.signUpPage.tosCheckBox_element.click if table_hash["TOS CheckBox"].upcase == "TRUE"

  @page_object.signUpPage.signUp_element.click

  WaitUtility.wait_untill_elements_size_steadied
end

Then(/^the system display the user email address$/) do
  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  
  expect(@page_object.profilePage.email).to eq @registration_table["Email address"]
end

#aboutMe --------------
Then(/^the profile Save button would be disable$/) do
  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)

  expect(@page_object.profilePage.save_element.enabled?).to eq(false), "The Save button expected to be disable"
end

When(/^the user save the information$/) do
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  @page_object.profilePage.save_element.click if @page_object.profilePage.save_element.enabled?
end

When(/^the user visit "([^"]*)" page$/) do |profile_option|
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  select_link(profile_option)
end

When(/^the user select "([^"]*)" from Profile section$/) do |profile_option|
@page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  select_link(profile_option)
end

Then(/^the system display the user name$/) do
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied
  expect(@page_object.profilePage.firstName).to eq @registration_table["First name"]
  expect(@page_object.profilePage.lastName).to eq @registration_table["Last name"]
end

Then(/^the system display the user date of birth$/) do
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  expect(@page_object.profilePage.birthYear).to eq @registration_table["Birth Year"]
  expect(@page_object.profilePage.birthMonth).to eq @registration_table["Birth Month"]
  expect(@page_object.profilePage.birthDay).to eq @registration_table["Birth Day"]
end

Then(/^the system will display below information under profile section$/) do |expect_table|
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  
  expect_table = expect_table.split("\n")

  application_content = @page_object.profilePage.profileContainer_element.text
  # p "#{application_content}"
  
  expect_table.each do |expect_data, x|
    expect(application_content.include? expect_data.strip).to be(true), "Could Not find: #{expect_data}\nin:\n#{application_content}"
  end
end

When(/^the user (?:edit|enter) the about me information$/) do |table|
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  SetData_SignUp = SetDataSignUp.new
  @entry_data = SetData_SignUp.set_data_sign_up(table)

  about_me_data_entry(@entry_data)
end

Then(/^the user will loss the above about me information if visit "([^"]*)" page$/) do |profile_option|
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  select_link(profile_option)

  select_link("About me")

  check_about_me_data(@entry_data, false)
end

Then(/^the user will not loss the above about me information if visit "([^"]*)" page$/) do |profile_option|
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  select_link(profile_option)

  select_link("About me")

  check_about_me_data(@entry_data, true)
end

def about_me_data_entry(expected_entry_data)
  @page_object.profilePage.firstName = expected_entry_data["First name"]
  @page_object.profilePage.lastName = expected_entry_data["Last name"]

  set_grade_gender(expected_entry_data["Grade"])

  set_grade_gender(expected_entry_data["Gender"])

  @page_object.profilePage.birthMonth = expected_entry_data["Birth Month"]
  @page_object.profilePage.birthDay = expected_entry_data["Birth Day"]
  @page_object.profilePage.birthYear = expected_entry_data["Birth Year"]

  set_citizenship(expected_entry_data["Citizenship"])

  @page_object.profilePage.ethnicity = expected_entry_data["Ethnicity"]
  @page_object.profilePage.race = expected_entry_data["Race"]
end

def check_about_me_data(expected_entry_data, matched)
  expect(@page_object.profilePage.firstName == expected_entry_data["First name"]).to eq(matched)
  expect(@page_object.profilePage.lastName == expected_entry_data["Last name"]).to eq(matched)

  check_grade_gender(expected_entry_data["Grade"], matched)

  check_grade_gender(expected_entry_data["Gender"], matched)

  expect(@page_object.profilePage.birthMonth == expected_entry_data["Birth Month"]).to eq(matched)
  expect(@page_object.profilePage.birthDay == expected_entry_data["Birth Day"]).to eq(matched)
  expect(@page_object.profilePage.birthYear == expected_entry_data["Birth Year"]).to eq(matched)

  expect(@page_object.profilePage.citizenship_element.text.gsub("\n✕", "") == expected_entry_data["Citizenship"]).to eq(matched)

  expect(@page_object.profilePage.ethnicity == expected_entry_data["Ethnicity"]).to eq(matched)
  expect(@page_object.profilePage.race == expected_entry_data["Race"]).to eq(matched)
end

def check_grade_gender(name_option, matched)
  WaitUtility.wait_untill_elements_size_steadied
  
  case name_option.downcase.strip
    when "freshman"
      expected_data = @page_object.profilePage.freshman_selected?
    when "sophomore"
      expected_data = @page_object.profilePage.sophomore_selected?
    when "junior"
      expected_data = @page_object.profilePage.junior_selected?
    when "senior"
      expected_data = @page_object.profilePage.education_selected?
    when "male"
      expected_data = @page_object.profilePage.male_selected?
    when "female"
      expected_data = @page_object.profilePage.female_selected?
    else
      fail "Please check your code. Could not find: #{name_option}"
  end
  expect(expected_data).to be(matched), "The #{name_option} radio button should be checked: #{matched}"
end

def set_grade_gender(name_option)
  WaitUtility.wait_untill_elements_size_steadied
  
  case name_option.downcase.strip
    when "freshman"
      @page_object.profilePage.freshman_element.click
    when "sophomore"
      @page_object.profilePage.sophomore_element.click
    when "junior"
      @page_object.profilePage.junior_element.click
    when "senior"
      @page_object.profilePage.senior_element.click
    when "male"
      @page_object.profilePage.male_element.click
    when "female"
      @page_object.profilePage.female_element.click
    else
      fail "Please check your code. Could not find: #{name_option}"
  end
end

def select_link(profile_option)
  WaitUtility.wait_untill_elements_size_steadied
  case profile_option.downcase.strip
    when "about me"
      @page_object.profilePage.aboutMe_element.click
    when "contact"
      @page_object.profilePage.contact_element.click
    when "payment"
      @page_object.profilePage.payment_element.click
    when "settings"
      @page_object.profilePage.settings_element.click
    when "education"
      @page_object.profilePage.education_element.click
    when "courses"
      @page_object.profilePage.courses_element.click
    when "tests"
      @page_object.profilePage.tests_element.click
    when "activities"
      @page_object.profilePage.activities_element.click
    when "achievements"
      @page_object.profilePage.achievements_element.click
    else
      fail "Please check your code. Could not find: #{profile_option}"
  end
end

def set_citizenship(country)
  @page_object.profilePage.citizenship_element.when_visible(TIME_OUT_LIMIT).click
  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.citizenshipInput = country

  BROWSER.send_keys :return
end



