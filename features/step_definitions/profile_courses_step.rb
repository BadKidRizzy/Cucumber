When(/^the user select Add another course$/) do
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  @page_object.profilePage.addItem_element.click 
end

When(/^the user select edit course$/) do
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  @page_object.profilePage.edit_element.click 
end

When(/^the courses record will be removed$/) do
  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  
  expect(@page_object.profilePage.edit_element.visible?).to be(false)  
end

When(/^the courses record will be displayed$/) do
  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  check_courses_data(@enter_table_hash) 
end


When(/^the user enter the courses info$/) do |table|
  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  
  @page_object.profilePage.addItem_element.click 

  @enter_table_hash = get_courses_table_hash(table)

  set_courses_data(@enter_table_hash)  
end

When(/^the user edit the courses info$/) do |table|
  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)

  @page_object.profilePage.edit_element.click 

  @edit_table_hash = get_courses_table_hash(table)

  set_courses_data(@edit_table_hash)  
end

Then(/^the user will loss the above courses info if navigate to "([^"]*)" page before saving the data$/) do |profile_option|
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  select_link(profile_option)

  select_link("courses")

  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  
  expect(@page_object.profilePage.edit_element.visible?).to be(false)  
end

Then(/^the Save button would be disable until the user enter all course required fields$/) do |table|
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  courses_table_hash = get_courses_table_hash(table)

  @page_object.profilePage.courseName = courses_table_hash["course name"]
  expect(@page_object.profilePage.save_element.enabled?).to eq(false), "The Save button expected to be disable"

  @page_object.profilePage.courseType = courses_table_hash["course type"]
  expect(@page_object.profilePage.save_element.enabled?).to eq(false), "The Save button expected to be disable"

  @page_object.profilePage.courseLevel = courses_table_hash["course level"]
  expect(@page_object.profilePage.save_element.enabled?).to eq(false), "The Save button expected to be disable"

  @page_object.profilePage.highestLevel = courses_table_hash["highest level"]
  expect(@page_object.profilePage.save_element.enabled?).to eq(false), "The Save button expected to be disable"

  @page_object.profilePage.gradingMethod = courses_table_hash["grading method"]
  expect(@page_object.profilePage.save_element.enabled?).to eq(false), "The Save button expected to be disable"

  @page_object.profilePage.finalGrade = courses_table_hash["final grade"]
  expect(@page_object.profilePage.save_element.enabled?).to be(true), "The Save button expected to be enable"
end

Then(/^the user will not loss the above courses info if visit "([^"]*)" page$/) do |profile_option|
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  select_link(profile_option)

  select_link("courses")

  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  @page_object.profilePage.edit_element.click

  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  check_courses_data(@enter_table_hash)  
end

Then(/^the user will not loss the above modification courses$/) do
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  @page_object.profilePage.edit_element.click

  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  check_courses_data(@edit_table_hash)  
end

Then(/^the user will disregard the above modification courses$/) do
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  @page_object.profilePage.edit_element.click

  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  check_courses_data(@enter_table_hash)  
end

def check_courses_data(courses_table_hash)
  # (expected_entry_data, matched)
  expect(@page_object.profilePage.courseName).to eq(courses_table_hash["course name"])
  expect(@page_object.profilePage.courseType).to eq(courses_table_hash["course type"])
  expect(@page_object.profilePage.courseLevel).to eq(courses_table_hash["course level"])
  expect(@page_object.profilePage.highestLevel).to eq(courses_table_hash["highest level"])
  expect(@page_object.profilePage.gradingMethod).to eq(courses_table_hash["grading method"])
  expect(@page_object.profilePage.finalGrade).to eq(courses_table_hash["final grade"])
 
end

def set_courses_data(courses_table_hash)
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  @page_object.profilePage.courseName = courses_table_hash["course name"]
  @page_object.profilePage.courseType = courses_table_hash["course type"]
  @page_object.profilePage.courseLevel = courses_table_hash["course level"]
  @page_object.profilePage.highestLevel = courses_table_hash["highest level"]
  @page_object.profilePage.gradingMethod = courses_table_hash["grading method"]
  @page_object.profilePage.finalGrade = courses_table_hash["final grade"]
end

def get_courses_table_hash(table)
  table_hash = {}
  table.rows.each do |key, value|
    table_hash[key.downcase] = value
  end
  return table_hash
end

