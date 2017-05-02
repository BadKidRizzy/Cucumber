When(/^the profile Save button will be enable$/) do 
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  expect(@page_object.profilePage.save_element.enabled?).to eq(true), "The Save button expected to be enable"
end

When(/^the user select "([^"]*)" test$/) do |test_name|
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  @page_object.profilePage.testType = test_name
end

When(/^the user select Add another test$/) do
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  @page_object.profilePage.addItem_element.click 
end

#enter -------------------
When(/^the user enter the test data$/) do |table|
  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)

  @page_object.profilePage.addItem_element.click 

  @enter_table_hash = get_test_table_hash(table)

  set_test_data(@enter_table_hash) 
end

When(/^the user edit the test info$/) do |table|
  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)

  @page_object.profilePage.edit_element.click 

  @edit_table_hash = get_test_table_hash(table)

  set_test_data(@edit_table_hash)  
end


#display -------------------
Then(/^the user will have below options to choose for IB subject$/) do |expected_table|
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied
  
  @page_object.profilePage.ibSubject_element.click
  actual_results = @page_object.profilePage.ibOptions_element.text
  
  expected_table = expected_table.split("\\n")

  actual_results = actual_results.split("\n")
  
  expect(actual_results-expected_table).to eq(expected_table-actual_results), "expected: #{expected_table}\n got: #{actual_results}\n diff: #{actual_results-expected_table}\n#{expected_table-actual_results}"
end

Then(/^the user will have below options to choose for subject$/) do |table|
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied
  expected_table = []

  actual_results = @page_object.profilePage.testSubject_options 
  actual_results = actual_results.reject(&:empty?)
  
  table.rows.each do |key, value|
    expected_table = expected_table + [key]
  end
  expect(actual_results-expected_table).to eq(expected_table-actual_results), "expected: #{expected_table}\n got: #{actual_results}\n diff: #{actual_results-expected_table}\n#{expected_table-actual_results}"
end

When(/^the test record will be removed$/) do
  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  
  expect(@page_object.profilePage.edit_element.visible?).to be(false)  
end

When(/^the test record will be displayed$/) do
  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  check_test_data(@enter_table_hash) 
end

Then(/^the user will loss the above test info if navigate to "([^"]*)" page before saving the data$/) do |profile_option|
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  select_link(profile_option)

  select_link("tests")

  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  
  expect(@page_object.profilePage.edit_element.visible?).to be(false)  
end

Then(/^the Save button would be disable until the user enter all test required fields$/) do |table|
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  test_table_hash = get_test_table_hash(table)

  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  @page_object.profilePage.testType = test_table_hash["test"]
  WaitUtility.wait_untill_elements_size_steadied
  expect(@page_object.profilePage.save_element.enabled?).to eq(false), "The Save button expected to be disable"

  @page_object.profilePage.testSubject = test_table_hash["subject"]
  WaitUtility.wait_untill_elements_size_steadied
  expect(@page_object.profilePage.save_element.enabled?).to eq(false), "The Save button expected to be disable"

  @page_object.profilePage.scoreTest = test_table_hash["score"]
  expect(@page_object.profilePage.save_element.enabled?).to eq(true), "The Save button expected to be enable"

  @page_object.profilePage.testDate_element.click
  enter_profile_date(test_table_hash["test date"], "start")
  expect(@page_object.profilePage.save_element.enabled?).to eq(true), "The Save button expected to be enable"
end

Then(/^the user will not loss the above test info if visit "([^"]*)" page$/) do |profile_option|
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  select_link(profile_option)

  select_link("tests")

  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  @page_object.profilePage.edit_element.click

  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  check_test_data(@enter_table_hash)  
end

Then(/^the user will not loss the above modification test$/) do
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  @page_object.profilePage.edit_element.click

  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  check_test_data(@edit_table_hash)  
end

Then(/^the user will disregard the above modification test$/) do
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  @page_object.profilePage.edit_element.click

  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  check_test_data(@enter_table_hash)  
end

def check_test_data(test_table_hash)
  # (expected_entry_data, matched)
  expect(@page_object.profilePage.testType).to eq(test_table_hash["test"])
  expect(@page_object.profilePage.testSubject).to eq(test_table_hash["subject"])
  expect(@page_object.profilePage.scoreTest).to eq(test_table_hash["score"])
  expect(@page_object.profilePage.testDate).to eq(test_table_hash["test date"])
end

def set_test_data(test_table_hash)
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  @page_object.profilePage.testType = test_table_hash["test"]
  WaitUtility.wait_untill_elements_size_steadied

  @page_object.profilePage.testSubject = test_table_hash["subject"]
  WaitUtility.wait_untill_elements_size_steadied

  @page_object.profilePage.scoreTest = test_table_hash["score"]

  @page_object.profilePage.testDate_element.click
  enter_profile_date(test_table_hash["test date"], "start")
end

def get_test_table_hash(table)
  table_hash = {}
  table.rows.each do |key, value|
    table_hash[key.downcase] = value
  end
  return table_hash
end


