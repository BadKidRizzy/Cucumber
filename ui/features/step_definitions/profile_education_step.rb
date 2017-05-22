When(/^the user select Add another education$/) do
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  @page_object.profilePage.addItem_element.click 
end

When(/^the user select edit education info$/) do
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  @page_object.profilePage.edit_element.click 
end

When(/^the user cancel the modification$/) do
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  @page_object.profilePage.cancel_element.click 
end

When(/^the user select Delete school$/) do
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  @page_object.profilePage.delete_element.click 
end

When(/^the user confirm the deletion$/) do
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  @page_object.profilePage.yesDelete_element.click 
end

When(/^the user disregard the deletion$/) do
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  @page_object.profilePage.cancelDelete_element.click 
end

When(/^the education record will be removed$/) do
  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  
  expect(@page_object.profilePage.edit_element.visible?).to be(false)  
end

When(/^the education record will be displayed$/) do
  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  check_education_data(@enter_table_hash) 
end


When(/^the user enter the education info$/) do |table|
  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  
  @page_object.profilePage.addItem_element.click if @page_object.profilePage.addItem_element.visible?

  @enter_table_hash = get_education_table_hash(table)

  set_education_data(@enter_table_hash)  
end

When(/^the user edit the education info$/) do |table|
  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)

  @page_object.profilePage.edit_element.click 

  @edit_table_hash = get_education_table_hash(table)

  set_education_data(@edit_table_hash)  
end

Then(/^the user will loss the above education info if navigate to "([^"]*)" page before saving the data$/) do |profile_option|
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  select_link(profile_option)

  select_link("Education")

  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  
  expect(@page_object.profilePage.edit_element.visible?).to be(false)  
end

Then(/^the user will not loss the above education info if visit "([^"]*)" page$/) do |profile_option|
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  select_link(profile_option)

  select_link("Education")

  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  @page_object.profilePage.edit_element.click

  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  check_education_data(@enter_table_hash)  
end

Then(/^the user will not loss the above modification education$/) do
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  @page_object.profilePage.edit_element.click

  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  check_education_data(@edit_table_hash)  
end

Then(/^the user will disregard the above modification education$/) do
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  @page_object.profilePage.edit_element.click

  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  check_education_data(@enter_table_hash)  
end

Then(/^the user delete all Profile data record$/) do
  result = true
  while result 
    begin
      WaitUtility.wait_untill_elements_size_steadied
      @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
    
      unless BROWSER.element.text.include? "Click the button above to add one"
        @page_object.profilePage.edit_element.when_visible(TIME_OUT_LIMIT).click
        @page_object.profilePage.delete_element.when_visible(TIME_OUT_LIMIT).click
        @page_object.profilePage.yesDelete_element.when_visible(TIME_OUT_LIMIT).click
        result = true
      else
        result = false
      end
    rescue Exception => e
      result = false
    end
  end
end

Then(/^the Save button would be disable until the user enter all education required fields$/) do |table|
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  education_table_hash = get_education_table_hash(table)

  @page_object.profilePage.schoolName = education_table_hash["high school"]
  expect(@page_object.profilePage.save_element.enabled?).to eq(false), "The Save button expected to be disable"

  if education_table_hash["intend to graduate"].downcase == 'yes'
    @page_object.profilePage.yesGrad_element.click
    expect(@page_object.profilePage.save_element.enabled?).to eq(false), "The Save button expected to be disable"
    
    @page_object.profilePage.graduationDate_element.click
    enter_profile_date(education_table_hash["graduation date"], "grad")
    expect(@page_object.profilePage.save_element.enabled?).to eq(false), "The Save button expected to be disable"
  else
    @page_object.profilePage.noGrad_element.click
    expect(@page_object.profilePage.save_element.enabled?).to eq(false), "The Save button expected to be disable"
    begin
      @page_object.profilePage.endDate_element.click
      enter_profile_date(education_table_hash["end date"], "grad")
    rescue Exception => e
      @page_object.profilePage.graduationDate_element.click
      enter_profile_date(education_table_hash["end date"], "grad")
    end
    expect(@page_object.profilePage.save_element.enabled?).to eq(false), "The Save button expected to be disable"
    
  end

  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.startDate_element.click
  enter_profile_date(education_table_hash["start date"], "start")
  expect(@page_object.profilePage.save_element.enabled?).to eq(false), "The Save button expected to be disable"

  @page_object.profilePage.uwGpa = education_table_hash["unweighted gpa"]
  expect(@page_object.profilePage.save_element.enabled?).to eq(true), "The Save button expected to be enable"
  
  @page_object.profilePage.wGpa = education_table_hash["weighted gpa"]
  expect(@page_object.profilePage.save_element.enabled?).to eq(false), "The Save button expected to be disable"

  @page_object.profilePage.tWGpa = education_table_hash["total weighted gpa"]
  expect(@page_object.profilePage.save_element.enabled?).to eq(true), "The Save button expected to be enable"
end

def check_education_data(education_table_hash)
  # (expected_entry_data, matched)
  expect(@page_object.profilePage.schoolName).to eq(education_table_hash["high school"])
  
  if education_table_hash["intend to graduate"].downcase == 'yes'
    expect(@page_object.profilePage.yesGrad?).to eq(true)
    expect(@page_object.profilePage.graduationDate).to eq(education_table_hash["graduation date"])
  else
    expect(@page_object.profilePage.noGrad?).to eq(true)
    expect(@page_object.profilePage.endDate).to eq(education_table_hash["end date"])
  end

  expect(@page_object.profilePage.startDate).to eq(education_table_hash["start date"]) 

  expect(@page_object.profilePage.uwGpa).to eq(education_table_hash["unweighted gpa"])
  expect(@page_object.profilePage.wGpa).to eq(education_table_hash["weighted gpa"])
  expect(@page_object.profilePage.tWGpa).to eq(education_table_hash["total weighted gpa"]) 
end

def set_education_data(education_table_hash)
  @page_object.profilePage.title_element.when_visible(TIME_OUT_LIMIT)
  WaitUtility.wait_untill_elements_size_steadied

  @page_object.profilePage.schoolName = education_table_hash["high school"]

  if education_table_hash["intend to graduate"].downcase == 'yes'
    @page_object.profilePage.yesGrad_element.click
    
    @page_object.profilePage.graduationDate_element.click
    enter_profile_date(education_table_hash["graduation date"], "grad")
  else
    @page_object.profilePage.noGrad_element.click
    begin
      @page_object.profilePage.endDate_element.click
      enter_profile_date(education_table_hash["end date"], "grad")
    rescue Exception => e
      @page_object.profilePage.graduationCross_element.click if @page_object.profilePage.graduationCross_element.visible?
      @page_object.profilePage.graduationDate_element.click
      enter_profile_date(education_table_hash["end date"], "grad")
    end 
  end

  WaitUtility.wait_untill_elements_size_steadied
  @page_object.profilePage.startCross_element.click if @page_object.profilePage.startCross_element.visible?
  @page_object.profilePage.startDate_element.click
  enter_profile_date(education_table_hash["start date"], "start")

  @page_object.profilePage.uwGpa = education_table_hash["unweighted gpa"]
  
  @page_object.profilePage.wGpa = education_table_hash["weighted gpa"]
  @page_object.profilePage.tWGpa = education_table_hash["total weighted gpa"]
end

def get_education_table_hash(table)
  table_hash = {}
  table.rows.each do |key, value|
    table_hash[key.downcase] = value
  end
  return table_hash
end

def enter_profile_date(date, option)
  WaitUtility.wait_untill_elements_size_steadied
  date = date.split("/")
  year = date[1].strip
  month = date[0].strip
  
  set_year_calendar(year, option)
  set_month_calendar(month.to_i, option)
end

def set_month_calendar(month, option)
  WaitUtility.wait_untill_elements_size_steadied
  if option == "start"
      date_table_ele = @page_object.profilePage.dateTableStart_element
    elsif option == "end"
      date_table_ele = @page_object.profilePage.dateTableEnd_element
    elsif option == "grad"
      date_table_ele = @page_object.profilePage.dateTableGard_element
    end
  
  date_table_ele[1][month - 1].click if (1 <= month && month <= 3)
  date_table_ele[2][month - 4].click if (4 <= month && month <= 6)
  date_table_ele[3][month - 7].click if (7 <= month && month <= 9)
  date_table_ele[4][month - 10].click if (10 <= month && month <= 12)
end

def set_year_calendar(year, option)
  WaitUtility.wait_untill_elements_size_steadied
  
  if option == "start"
    current_year = @page_object.profilePage.yearTextStart_element.text
    index = set_right_left(year, current_year)
    current_ele = @page_object.profilePage.yearRightStart_element if index > 0 
    current_ele = @page_object.profilePage.yearLeftStart_element if index < 0 
  elsif option == "end"
    current_year = @page_object.profilePage.yearTextEnd_element.text
    index = set_right_left(year, current_year)
    current_ele = @page_object.profilePage.yearRightEnd_element if index > 0 
    current_ele = @page_object.profilePage.yearLeftEnd_element if index < 0 
  elsif option == "grad"
    current_year = @page_object.profilePage.yearTextGrad_element.text
    index = set_right_left(year, current_year)
    current_ele = @page_object.profilePage.yearRightGrad_element if index > 0 
    current_ele = page_object.profilePage.yearLeftGrad_element if index < 0 
  end

  for i in 0..index.abs-1
    current_ele.click
  end

end

def set_right_left(year, current_year)
  current_year = current_year.to_i

  index = year.to_i - current_year
  return index
end

