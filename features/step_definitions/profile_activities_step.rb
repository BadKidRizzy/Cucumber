When(/^the user select Add another activity$/) do
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  @page_object.profilePage.addItem_element.click 
end

# #enter -------------------
When(/^the user enter the activity data$/) do |table|
  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)

  @page_object.profilePage.addItem_element.click 

  @enter_table_hash = get_activity_table_hash(table)

  set_activity_data(@enter_table_hash) 
end

When(/^the user edit the activity info$/) do |table|
  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)

  @page_object.profilePage.edit_element.click 

  @edit_table_hash = get_activity_table_hash(table)

  set_activity_data(@edit_table_hash)  
end


# #display -------------------


When(/^the activity record will be removed$/) do
  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  
  expect(@page_object.profilePage.edit_element.visible?).to be(false)  
end

When(/^the activity record will be displayed$/) do
  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  check_activity_data(@enter_table_hash) 
end

Then(/^the user will loss the above activity info if navigate to "([^"]*)" page before saving the data$/) do |profile_option|
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  select_link(profile_option)

  select_link("Activities")

  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  
  expect(@page_object.profilePage.edit_element.visible?).to be(false)  
end

Then(/^the Save button would be disable until the user enter all activity required fields$/) do |table|
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  activity_table_hash = get_activity_table_hash(table)

  @page_object.profilePage.activityName = activity_table_hash["name of activity"]
  expect(@page_object.profilePage.save_element.enabled?).to eq(false), "The Save button expected to be disable"

  @page_object.profilePage.activityType = activity_table_hash["type of activity"]
  WaitUtility.wait_untill_elements_size_steadied
  expect(@page_object.profilePage.save_element.enabled?).to eq(false), "The Save button expected to be disable"

  set_grade_do(activity_table_hash["grade"])
  WaitUtility.wait_untill_elements_size_steadied
  expect(@page_object.profilePage.save_element.enabled?).to eq(false), "The Save button expected to be disable"

  set_participate(activity_table_hash["participate"])
  WaitUtility.wait_untill_elements_size_steadied
  expect(@page_object.profilePage.save_element.enabled?).to eq(false), "The Save button expected to be disable"

  set_hours(activity_table_hash["hours"])
  WaitUtility.wait_untill_elements_size_steadied
  expect(@page_object.profilePage.save_element.enabled?).to eq(false), "The Save button expected to be disable"

  @page_object.profilePage.description = activity_table_hash["description"]
  expect(@page_object.profilePage.save_element.enabled?).to eq(true), "The Save button expected to be enable"
end

Then(/^the user will not loss the above activity info if visit "([^"]*)" page$/) do |profile_option|
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  select_link(profile_option)

  select_link("Activities")

  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  @page_object.profilePage.edit_element.click

  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  check_activity_data(@enter_table_hash)  
end

Then(/^the user will not loss the above modification activity$/) do
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  @page_object.profilePage.edit_element.click

  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  check_activity_data(@edit_table_hash)  
end

Then(/^the user will disregard the above modification activity$/) do
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  @page_object.profilePage.edit_element.click

  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  check_activity_data(@enter_table_hash)  
end

def check_activity_data(activity_table_hash)
  expect(@page_object.profilePage.activityName).to eq(activity_table_hash["name of activity"])
  expect(@page_object.profilePage.activityType).to eq(activity_table_hash["type of activity"])

  check_grade_do(activity_table_hash["grade"])

  check_participate(activity_table_hash["participate"])

  check_hours(activity_table_hash["hours"])

  expect(@page_object.profilePage.description).to eq(activity_table_hash["description"])
end

def set_activity_data(activity_table_hash)
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  @page_object.profilePage.activityName = activity_table_hash["name of activity"]
  @page_object.profilePage.activityType = activity_table_hash["type of activity"]
  WaitUtility.wait_untill_elements_size_steadied

  set_grade_do(activity_table_hash["grade"])

  set_participate(activity_table_hash["participate"])

  set_hours(activity_table_hash["hours"])

  @page_object.profilePage.description = activity_table_hash["description"]
end

def get_activity_table_hash(table)
  table_hash = {}
  table.rows.each do |key, value|
    table_hash[key.downcase] = value
  end
  return table_hash
end

def set_participate(name_option)
  WaitUtility.wait_untill_elements_size_steadied

  case name_option.downcase.strip
    when "during school"
      @page_object.profilePage.duringSchool_element.click
    when "over breaks"
      @page_object.profilePage.overBreaks_element.click
    when "all year"
      @page_object.profilePage.allYear_element.click
    else
      fail "Please check your code. Could not find: #{name_option}"
  end
end

def set_hours(name_option)
  WaitUtility.wait_untill_elements_size_steadied
  if name_option.include? ";"
    hours_weeks = name_option.split(";")
    hours = hours_weeks[0].split("=")[1]
    weeks = hours_weeks[1].split("=")[1]

    @page_object.profilePage.perWeekHours_element.click
    WaitUtility.wait_untill_elements_size_steadied

    @page_object.profilePage.hoursPerWeek = hours.to_i
    @page_object.profilePage.weeksPerYear = weeks.to_i
  else
    hours = name_option.split("=")[1]

    @page_object.profilePage.totalHours_element.click
    WaitUtility.wait_untill_elements_size_steadied

    @page_object.profilePage.hours = hours.to_i
  end
end

def set_grade_do(name_option)
  WaitUtility.wait_untill_elements_size_steadied
  name_options = name_option.split(";")

  name_options.each do |name_option|
    case name_option.downcase.strip
      when "freshman"
        @page_object.profilePage.freshmanDo_element.click
      when "sophomore"
        @page_object.profilePage.sophomoreDo_element.click
      when "junior"
        @page_object.profilePage.juniorDo_element.click
      when "senior"
        @page_object.profilePage.seniorDo_element.click
      else
        fail "Please check your code. Could not find: #{name_option}"
    end
  end
end
# ---------
def check_participate(name_option)
  WaitUtility.wait_untill_elements_size_steadied

  case name_option.downcase.strip
    when "during school"
      selected = @page_object.profilePage.duringSchool_selected?
    when "over breaks"
      selected = @page_object.profilePage.overBreaks_selected?
    when "all year"
      selected = @page_object.profilePage.allYear_selected?
    else
      fail "Please check your code. Could not find: #{name_option}"
  end
  expect(selected).to eq(true), "The #{name_option} should be selected" 
end

def check_hours(name_option)
  WaitUtility.wait_untill_elements_size_steadied
  if name_option.include? ";"
    hours_weeks = name_option.split(";")
    hours = hours_weeks[0].split("=")[1]
    weeks = hours_weeks[1].split("=")[1]

    expect(@page_object.profilePage.perWeekHours_selected?).to be(true), "The Per Week should be selected"
    WaitUtility.wait_untill_elements_size_steadied

    expect(@page_object.profilePage.hoursPerWeek).to eq(hours)
    expect(@page_object.profilePage.weeksPerYear).to eq(weeks)
  else
    hours = name_option.split("=")[1]

    expect(@page_object.profilePage.totalHours_selected?).to be(true), "The Total should be selected"
    WaitUtility.wait_untill_elements_size_steadied

    expect(@page_object.profilePage.hours).to eq(hours)
  end
end

def check_grade_do(name_option, validate=true)
  WaitUtility.wait_untill_elements_size_steadied
  name_options = name_option.split(";")
  checked = false

  name_options.each do |name_option|
    case name_option.downcase.strip
      when "freshman"
        checked = @page_object.profilePage.freshmanDo_checked?
      when "sophomore"
        checked = @page_object.profilePage.sophomoreDo_checked?
      when "junior"
        checked = @page_object.profilePage.juniorDo_checked?
      when "senior"
        checked = @page_object.profilePage.seniorDo_checked?
      else
        fail "Please check your code. Could not find: #{name_option}" 
    end
    expect(checked).to eq(true), "The #{name_option} should be selected" if validate
  end
  return checked unless validate
end
