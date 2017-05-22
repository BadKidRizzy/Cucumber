When(/^the user select Add another achievement$/) do
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  @page_object.profilePage.addItem_element.click 
end

# # #enter -------------------
When(/^the user enter the achievement data$/) do |table|
  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)

  @page_object.profilePage.addItem_element.click if @page_object.profilePage.addItem_element.visible?

  @enter_table_hash = get_achievement_table_hash(table)

  set_achievement_data(@enter_table_hash) 
end

When(/^the user edit the achievement info$/) do |table|
  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)

  @page_object.profilePage.edit_element.click 

  @edit_table_hash = get_achievement_table_hash(table)

  clear_level_achievement("high school;local;district;state or regional;national;international")
  clear_garde_level("freshman;sophomore;junior;senior")
  set_achievement_data(@edit_table_hash)  
end


# # #display -------------------


When(/^the achievement record will be removed$/) do
  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  
  expect(@page_object.profilePage.edit_element.visible?).to be(false)  
end

When(/^the achievement record will be displayed$/) do
  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  check_achievement_data(@enter_table_hash) 
end

Then(/^the user will loss the above achievement info if navigate to "([^"]*)" page before saving the data$/) do |profile_option|
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  select_link(profile_option)

  select_link("Achievements")

  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  
  expect(@page_object.profilePage.edit_element.visible?).to be(false)  
end

Then(/^the Save button would be disable until the user enter all achievement required fields$/) do |table|
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  achievement_table_hash = get_achievement_table_hash(table)

  @page_object.profilePage.achieveTitle = achievement_table_hash["title of achievement"]
  expect(@page_object.profilePage.save_element.enabled?).to eq(false), "The Save button expected to be disable"

  set_level_achievement(achievement_table_hash["level of achievement"])
  expect(@page_object.profilePage.save_element.enabled?).to eq(false), "The Save button expected to be disable"

  set_grade_do(achievement_table_hash["grade level"])
  expect(@page_object.profilePage.save_element.enabled?).to eq(false), "The Save button expected to be disable"

  @page_object.profilePage.achieveDescription = achievement_table_hash["description"]
  expect(@page_object.profilePage.save_element.enabled?).to eq(true), "The Save button expected to be enable"
end

Then(/^the user will not loss the above achievement info if visit "([^"]*)" page$/) do |profile_option|
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  select_link(profile_option)

  select_link("Achievements")

  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  @page_object.profilePage.edit_element.click

  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  check_achievement_data(@enter_table_hash)  
end

Then(/^the user will not loss the above modification achievement$/) do
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  @page_object.profilePage.edit_element.click

  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  check_achievement_data(@edit_table_hash)  
end

Then(/^the user will disregard the above modification achievement$/) do
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  @page_object.profilePage.edit_element.click

  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  check_achievement_data(@enter_table_hash)  
end

def check_achievement_data(achievement_table_hash)
  expect(@page_object.profilePage.achieveTitle).to eq(achievement_table_hash["title of achievement"])
 
  check_level_achievement(achievement_table_hash["level of achievement"])

  check_grade_do(achievement_table_hash["grade level"])

  expect(@page_object.profilePage.achieveDescription).to eq(achievement_table_hash["description"])
end

def set_achievement_data(achievement_table_hash)
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  @page_object.profilePage.achieveTitle = achievement_table_hash["title of achievement"]

  set_level_achievement(achievement_table_hash["level of achievement"])

  set_grade_do(achievement_table_hash["grade level"])

  @page_object.profilePage.achieveDescription = achievement_table_hash["description"]
end

def get_achievement_table_hash(table)
  table_hash = {}
  table.rows.each do |key, value|
    table_hash[key.downcase] = value
  end
  return table_hash
end

def set_level_achievement(name_option)
  WaitUtility.wait_untill_elements_size_steadied
  name_options = name_option.split(";")

  name_options.each do |name_option|
    case name_option.downcase.strip
      when "high school"
        @page_object.profilePage.achHs_element.click
      when "local"
        @page_object.profilePage.achLoc_element.click
      when "district"
        @page_object.profilePage.achDist_element.click
      when "state or regional"
        @page_object.profilePage.achState_element.click
      when "national"
        @page_object.profilePage.achNat_element.click
      when "international"
        @page_object.profilePage.achInt_element.click
      else
        fail "Please check your code. Could not find: #{name_option}"
    end
  end
end

def check_level_achievement(name_option, validate=true)
  WaitUtility.wait_untill_elements_size_steadied
  name_options = name_option.split(";")
  checked = false

  name_options.each do |name_option|
    case name_option.downcase.strip
      when "high school"
        checked = @page_object.profilePage.achHs_checked?
      when "local"
        checked = @page_object.profilePage.achLoc_checked?
      when "district"
        checked = @page_object.profilePage.achDist_checked?
      when "state or regional"
        checked = @page_object.profilePage.achState_checked?
      when "national"
        checked = @page_object.profilePage.achNat_checked?
      when "international"
        checked = @page_object.profilePage.achInt_checked?
      else
        fail "Please check your code. Could not find: #{name_option}"
    end
    expect(checked).to eq(true), "The #{name_option} should be selected" if validate
  end
  return checked unless validate
end

def clear_level_achievement(name_option)
  name_options = name_option.split(";")
  name_options.each do |name_option|
    set_level_achievement(name_option) if check_level_achievement(name_option, false)
  end
end

def clear_garde_level(name_option)
  name_options = name_option.split(";")
  name_options.each do |name_option|
    set_grade_do(name_option) if check_grade_do(name_option, false)
  end
end

