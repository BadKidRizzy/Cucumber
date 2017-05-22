When(/^the user try to login using the update email$/) do
  page_url = URLS + @page_object.homePage.page_url_value
  puts "****** The expect page url: #{page_url} ******"
  puts "****** The current page url: #{BROWSER.url} ******"

  BROWSER.goto page_url
  @page_object.homePage.login_element.when_visible(TIME_OUT_LIMIT)
  @page_object.homePage.login_element.click
  WaitUtility.wait_untill_elements_size_steadied

  @page_object.loginPage.email_element.when_visible(TIME_OUT_LIMIT)

  @page_object.loginPage.email = @entry_data["Email address"]
  @page_object.loginPage.password = @registration_table["Password"]

  @page_object.loginPage.login_element.click
  WaitUtility.waitWhileSpinnerPresent(45)
  fail "The login failed!" if @page_object.profilePage.errorDiv_element.visible?
end

When(/^the user (?:edit|enter) the contact information$/) do |table|
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  SetData_SignUp = SetDataSignUp.new
  @entry_data = SetData_SignUp.set_data_sign_up(table)

  contact_data_entry(@entry_data)
end

Then(/^the user will loss the above contact information if visit "([^"]*)" page$/) do |profile_option|
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  select_link(profile_option)

  select_link("Contact")

  check_contact_data(@entry_data, false)
end

Then(/^the user will not loss the above contact information if visit "([^"]*)" page$/) do |profile_option|
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  select_link(profile_option)

  select_link("Contact")

  check_contact_data(@entry_data, true)
end

def contact_data_entry(expected_entry_data)
  # @page_object.profilePage.email = expected_entry_data["Email address"]
  @page_object.profilePage.phone = expected_entry_data["Phone Number"]

  @page_object.profilePage.parentEmail = expected_entry_data["Parent Email"]
  set_citizenship(expected_entry_data["Country"])
  @page_object.profilePage.address1 = expected_entry_data["Address Line 1"]
  @page_object.profilePage.address2 = expected_entry_data["Address Line 2"]

  @page_object.profilePage.city = expected_entry_data["City"]
  @page_object.profilePage.state = expected_entry_data["State/Province/Region"]
  @page_object.profilePage.zip = expected_entry_data["Zip/Postal Code"]
end

def check_contact_data(expected_entry_data, matched)
  # expect(@page_object.profilePage.email == expected_entry_data["Email address"]).to eq(matched)
  expect(@page_object.profilePage.phone == expected_entry_data["Phone Number"]).to eq(matched)
  expect(@page_object.profilePage.parentEmail == expected_entry_data["Parent Email"]).to eq(matched)
  
  expect(@page_object.profilePage.citizenship_element.text.gsub("\n✕", "") == expected_entry_data["Country"]).to eq(matched)

  expect(@page_object.profilePage.address1 == expected_entry_data["Address Line 1"]).to eq(matched) 
  expect(@page_object.profilePage.address2 == expected_entry_data["Address Line 2"]).to eq(matched)

  expect(@page_object.profilePage.city == expected_entry_data["City"]).to eq(matched)
  expect(@page_object.profilePage.state == expected_entry_data["State/Province/Region"]).to eq(matched)
  expect(@page_object.profilePage.zip == expected_entry_data["Zip/Postal Code"]).to eq(matched)
end

def set_citizenship(country)
  @page_object.profilePage.citizenship_element.when_visible(TIME_OUT_LIMIT).click
  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.citizenshipInput = country

  BROWSER.send_keys :return
end



