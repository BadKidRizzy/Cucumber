When(/^the user (?:edit|enter) the notifications setting$/) do |table|
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  SetData_SignUp = SetDataSignUp.new
  @entry_data = SetData_SignUp.set_data_sign_up(table)

  notifications_data_entry(@entry_data)
end

Then(/^the user will loss the above notifications setting if visit "([^"]*)" page$/) do |profile_option|
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  select_link(profile_option)

  select_link("Settings")

  check_notifications_data(@entry_data, false)
end

Then(/^the user will not loss the above notifications setting if visit "([^"]*)" page$/) do |profile_option|
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  select_link(profile_option)

  select_link("Settings")

  check_notifications_data(@entry_data, true)
end

When(/^the user set Web Notifications Frequency as "([^"]*)"$/) do |frequency|
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  @page_object.profilePage.webNotifications_element.click if box_checked?('web') == 'off'
  set_frequency(frequency, 'web')
end

Then(/^the "([^"]*)" Web Notifications Frequency is selected$/) do |frequency|
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  check_frequency(frequency, 'web')
end

When(/^the user turn off the Web Notifications$/) do
  @page_object.profilePage.webNotifications_element.click unless box_checked?('web') == 'off'
end

Then(/^the Web Notifications Frequency is disabled$/) do
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  expect(@page_object.profilePage.webDaily_element.enabled?).to be(false), "The Web Notifications Frequency should be disabled"
end

When(/^the user set Marketing Emails Frequency as "([^"]*)"$/) do |frequency|
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  @page_object.profilePage.marketingEmails_element.click if box_checked?('marketing') == 'off'
  set_frequency(frequency, 'marketing')
end

Then(/^the "([^"]*)" Marketing Emails Frequency is selected$/) do |frequency|
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  check_frequency(frequency, 'marketing')
end

When(/^the user turn off the Marketing Emails$/) do
  @page_object.profilePage.marketingEmails_element.click unless box_checked?('marketing') == 'off'
end

Then(/^the Marketing Emails Frequency is disabled$/) do
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  expect(@page_object.profilePage.webDaily_element.enabled?).to be(false), "The Web Notifications Frequency should be disabled"
end

When(/^the user enter the current password "([^"]*)"$/) do |current_password|
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  @page_object.profilePage.currentPassword = current_password
end

When(/^the user enter the new and re-type new password "([^"]*)"$/) do |newPassword|
  @page_object.profilePage.newPassword = newPassword
  @page_object.profilePage.reTypeNewPassword = newPassword
end

Then(/^the user should be able to login using "([^"]*)" and new password "([^"]*)"$/) do |email, password|
  page_url = URLS + @page_object.homePage.page_url_value
  puts "****** The expect page url: #{page_url} ******"
  puts "****** The current page url: #{BROWSER.url} ******"

  BROWSER.goto page_url
  @page_object.homePage.login_element.when_visible(TIME_OUT_LIMIT)
  @page_object.homePage.login_element.click
  WaitUtility.wait_untill_elements_size_steadied

  @page_object.loginPage.email_element.when_visible(TIME_OUT_LIMIT)

  @page_object.loginPage.email = email
  @page_object.loginPage.password = password

  @page_object.loginPage.login_element.click
  WaitUtility.waitWhileSpinnerPresent(45)
  fail "The login failed!" if @page_object.profilePage.errorDiv_element.visible?
end

def notifications_data_entry(expected_entry_data)
  @page_object.profilePage.emailNotifications_element.click unless box_checked?('email') == expected_entry_data["Email Notifications"].downcase
  @page_object.profilePage.webNotifications_element.click unless box_checked?('web') == expected_entry_data["Web Notifications"].downcase
   
  set_frequency(expected_entry_data["Web Notifications Frequency"], 'web') if box_checked?('web') == 'on'
  
  @page_object.profilePage.textNotifications_element.click unless box_checked?('text') == expected_entry_data["Text Notifications"].downcase
  @page_object.profilePage.marketingEmails_element.click unless box_checked?('marketing') == expected_entry_data["Marketing Emails"].downcase
   
  set_frequency(expected_entry_data["Marketing Emails Frequency"], 'marketing') if box_checked?('marketing') == 'on'
end

def check_notifications_data(expected_entry_data, matched)
  if expected_entry_data["Email Notifications"].downcase == 'off' && matched == false
    expect(box_checked?('email') == expected_entry_data["Email Notifications"].downcase).to eq(true)
  else
    expect(box_checked?('email') == expected_entry_data["Email Notifications"].downcase).to eq(matched)
  end
  
  if expected_entry_data["Web Notifications"].downcase == 'off' && matched == false
    expect(box_checked?('web') == expected_entry_data["Web Notifications"].downcase).to eq(true)
  else
    expect(box_checked?('web') == expected_entry_data["Web Notifications"].downcase).to eq(matched)
  end
  
  expect(check_frequency(expected_entry_data["Web Notifications Frequency"], 'web')).to eq(matched) if box_checked?('web') == 'on'
  
  if expected_entry_data["Text Notifications"].downcase == 'off' && matched == false
    expect(box_checked?('text') == expected_entry_data["Text Notifications"].downcase).to eq(true) 
  else
    expect(box_checked?('text') == expected_entry_data["Text Notifications"].downcase).to eq(matched) 
  end

  if expected_entry_data["Marketing Emails"].downcase == 'off' && matched == false
    expect(box_checked?('marketing') == expected_entry_data["Marketing Emails"].downcase).to eq(true)
  else
    expect(box_checked?('marketing') == expected_entry_data["Marketing Emails"].downcase).to eq(matched)
  end

  expect(check_frequency(expected_entry_data["Marketing Emails Frequency"], 'marketing')).to eq(matched) if box_checked?('web') == 'on'
  
end

def box_checked?(ele_name)
  box_check = "off"
  ele = BROWSER.element(:name => ele_name)
  ele_class = ele.attribute_value 'class'
  box_check = "on" if ele_class.include? "checked"
  return box_check
end

def set_frequency(frequency, which)
  frequency_name = which + '-' + frequency  
  case frequency_name.downcase
  when 'web-daily'
    @page_object.profilePage.webDaily_element.click
  when 'web-weekly'
    @page_object.profilePage.webWeekly_element.click
  when 'web-monthly'
    @page_object.profilePage.webMonthly_element.click
  when 'marketing-daily'
    @page_object.profilePage.marketingDaily_element.click
  when 'marketing-weekly'
    @page_object.profilePage.marketingWeekly_element.click
  when 'marketing-monthly'
    @page_object.profilePage.marketingMonthly_element.click
  else
    fail " There is not code for: #{frequency} in #{which} section"
  end
end

def check_frequency(frequency, which)
  frequency_name = which + '-' + frequency  
  case frequency_name.downcase
  when 'web-daily'
    selected = @page_object.profilePage.webDaily_selected?
  when 'web-weekly'
    selected = @page_object.profilePage.webWeekly_selected?
  when 'web-monthly'
    selected = @page_object.profilePage.webMonthly_selected?
  when 'marketing-daily'
    selected = @page_object.profilePage.marketingDaily_selected?
  when 'marketing-weekly'
    selected = @page_object.profilePage.marketingWeekly_selected?
  when 'marketing-monthly'
    selected = @page_object.profilePage.marketingMonthly_selected?
  else
    fail " There is not code for: #{frequency} in #{which} section"
  end
  return selected
end




