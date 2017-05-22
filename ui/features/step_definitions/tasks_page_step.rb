When(/^the user select "([^"]*)" task status$/) do |btn_name|
  WaitUtility.wait_untill_elements_size_steadied

  if btn_name.downcase == "active"
    @page_object.tasksPage.activeStatus_element.when_visible(TIME_OUT_LIMIT).click
  elsif btn_name.downcase == "complete"
    @page_object.tasksPage.completeStatus_element.when_visible(TIME_OUT_LIMIT).click
  else
    fail "There is no code for button: #{btn_name}"
  end
end

When(/^the user select "([^"]*)" from tasks page$/) do |btn_name|
  WaitUtility.wait_untill_elements_size_steadied

  if btn_name.downcase == "create task"
    @page_object.tasksPage.createTask_element.when_visible(TIME_OUT_LIMIT).click
  elsif btn_name.downcase == "create first task"
    @page_object.tasksPage.createFirstTask_element.when_visible(TIME_OUT_LIMIT).click
  else
    fail "There is no code for button: #{btn_name}"
  end
end

Then(/^the user open the existing task in edit mode$/) do
  WaitUtility.wait_untill_elements_size_steadied

  @page_object.tasksPage.firstTitle_element.when_visible(TIME_OUT_LIMIT).click
end

Then(/^the user delete the task and confirmed$/) do
  WaitUtility.wait_untill_elements_size_steadied

  @page_object.tasksPage.firstTitle_element.click
  WaitUtility.wait_untill_elements_size_steadied
  @page_object.tasksPage.deleteTask_element.when_visible(TIME_OUT_LIMIT).click
  @page_object.tasksPage.yesDeleteTask_element.when_visible(TIME_OUT_LIMIT).click
end

Then(/^the user delete the task but did not confirm$/) do
  WaitUtility.wait_untill_elements_size_steadied

  @page_object.tasksPage.firstTitle_element.click
  WaitUtility.wait_untill_elements_size_steadied
  @page_object.tasksPage.deleteTask_element.when_visible(TIME_OUT_LIMIT).click
  @page_object.tasksPage.cancelDeleteTask_element.when_visible(TIME_OUT_LIMIT).click
end

When(/^the save task button would be disabled$/) do
  WaitUtility.wait_untill_elements_size_steadied

  expect(@page_object.tasksPage.saveTask_element.enabled?).to eq(false), "the save button would be disabled"
end

When(/^the save task button would be enabled$/) do
  WaitUtility.wait_untill_elements_size_steadied

  expect(@page_object.tasksPage.saveTask_element.enabled?).to eq(true), "the save button would be enabled"
end

When(/^the cancel task button would be enabled$/) do
  WaitUtility.wait_untill_elements_size_steadied

  expect(@page_object.tasksPage.cancelTask_element.enabled?).to eq(true), "the cancel button would be enabled"
end

When(/^the remind me on the due date check box will be checked$/) do
  WaitUtility.wait_untill_elements_size_steadied

  expect(@page_object.tasksPage.onDueDate_checked?).to eq(true), "the onDueDate button would be checked"
end

When(/^the remind me on the due date check box will be unchecked$/) do
  WaitUtility.wait_untill_elements_size_steadied

  expect(@page_object.tasksPage.onDueDate_checked?).to eq(false), "the onDueDate button would be unchecked"
end

When(/^the user unchecked the check box for by email$/) do
  WaitUtility.wait_untill_elements_size_steadied

  @page_object.tasksPage.byEmail_element.click if @page_object.tasksPage.byEmail_checked? == true
end

When(/^the user checked the check box for by text$/) do
  WaitUtility.wait_untill_elements_size_steadied

  @page_object.tasksPage.byText_element.click if @page_object.tasksPage.byText_checked? == false
end

When(/^the user unchecked the check box for by text$/) do
  WaitUtility.wait_untill_elements_size_steadied

  @page_object.tasksPage.byText_element.click if @page_object.tasksPage.byText_checked? == true
end

When(/^the user unchecked the check box for remind me on the due date$/) do
  WaitUtility.wait_untill_elements_size_steadied

  @page_object.tasksPage.onDueDate_element.click if @page_object.tasksPage.onDueDate_checked? == true
end

When(/^the user check the task as complete$/) do
  WaitUtility.wait_untill_elements_size_steadied

  @page_object.tasksPage.firstComplete_element.click

  Watir::Wait.until { BROWSER.button(text: "undo").visible? }
  
  begin
    Watir::Wait.while { BROWSER.button(text: "undo").visible? }
  rescue Exception => e
    
  end

end

When(/^the user click on Compelete Task button$/) do
  WaitUtility.wait_untill_elements_size_steadied

  @page_object.tasksPage.completeTask_element.click
end

When(/^the user click on cancel button$/) do
  WaitUtility.wait_untill_elements_size_steadied

  @page_object.tasksPage.cancelTask_element.click
end

# Given(/^the user select a university$/) do
#   WaitUtility.wait_untill_elements_size_steadied
#   table = @page_object.searchSchoolsPage.searchResults_element
#   table[1][0].click
# end

# When(/^the user select the university as favorite$/) do
#   WaitUtility.wait_untill_elements_size_steadied
#   table = @page_object.searchSchoolsPage.searchResults_element
#   table[1][0].click

#   WaitUtility.wait_untill_elements_size_steadied
#   class_text = @page_object.tasksPage.favoriteDetail_element.when_visible(TIME_OUT_LIMIT).attribute("class")
#   @page_object.tasksPage.favoriteDetail_element.when_visible(TIME_OUT_LIMIT).click if class_text.include? "outline"
# end

# When(/^the system should display asterisk for required field - title$/) do
#   WaitUtility.wait_untill_elements_size_steadied
#   fail "Write the code for - Display asterisk for required field"
# end


When(/^the user (?:edit|add) and save task$/) do |table|
  @table_hash = table_hash(table)
  WaitUtility.wait_untill_elements_size_steadied
  
  @page_object.tasksPage.titleTask = @table_hash["Title"]
  @page_object.tasksPage.bodyTask = @table_hash["Description"]

  enter_due_date()

  WaitUtility.wait_untill_elements_size_steadied
  @page_object.tasksPage.onDueDate_element.click if @table_hash["On the Due Date"] == "true"
  
  set_day_before_due_date() if @table_hash["Day before due date"].to_i > 0
  
  WaitUtility.wait_untill_elements_size_steadied
  @page_object.tasksPage.byEmail_element.click if @table_hash["By Email"] == 'true'

  if @table_hash["By text"] == 'true'
    WaitUtility.wait_untill_elements_size_steadied
    @page_object.tasksPage.byText_element.click
    WaitUtility.wait_untill_elements_size_steadied
    
    if @page_object.tasksPage.phoneText_element.visible?
      @page_object.tasksPage.phoneText = @table_hash["Phone number"]
      WaitUtility.wait_untill_elements_size_steadied
      expect(@page_object.tasksPage.savePhone_element.enabled?).to eq(true), "the save phone button would be enabled"
      @page_object.tasksPage.savePhone_element.click
    end
  end

  @page_object.tasksPage.saveTask_element.click
  
end

When(/^the user (?:edit|add) and cancel the change$/) do |table|
  @table_hash_edit = table_hash(table)
  WaitUtility.wait_untill_elements_size_steadied
  
  @page_object.tasksPage.titleTask = @table_hash_edit["Title"]
  @page_object.tasksPage.bodyTask = @table_hash_edit["Description"]

  enter_due_date()

  WaitUtility.wait_untill_elements_size_steadied
  @page_object.tasksPage.onDueDate_element.click if @table_hash_edit["On the Due Date"] == "true"
  
  set_day_before_due_date() if @table_hash_edit["Day before due date"].to_i > 0
  
  WaitUtility.wait_untill_elements_size_steadied
  @page_object.tasksPage.byEmail_element.click if @table_hash_edit["By Email"] == 'true'

  if @table_hash_edit["By text"] == 'true'
    WaitUtility.wait_untill_elements_size_steadied
    @page_object.tasksPage.byText_element.click
    WaitUtility.wait_untill_elements_size_steadied
    
    if @page_object.tasksPage.phoneText_element.visible?
      @page_object.tasksPage.phoneText = @table_hash_edit["Phone number"]
      WaitUtility.wait_untill_elements_size_steadied
      expect(@page_object.tasksPage.savePhone_element.enabled?).to eq(true), "the save phone button would be enabled"
      @page_object.tasksPage.savePhone_element.click
    end
  end

  @page_object.tasksPage.cancelTask_element.click
  
end

When(/^the user updates the Day before due date to "([^"]*)"$/) do |day|
  @table_hash["Day before due date"] = day
  set_day_before_due_date() if @table_hash["Day before due date"].to_i > 0
end


# When(/^the user add but did not save note$/) do |table|
#   table.rows.each do |key, value|
#     @page_object.tasksPage.titleNote = key
#     @page_object.tasksPage.bodyNote = value
#   end
# end

# When(/^the user select Notes from detail page$/) do
#   WaitUtility.wait_untill_elements_size_steadied

#   @page_object.tasksPage.notes_element.when_visible(TIME_OUT_LIMIT).click
# end

When(/^the user delete all existing tasks$/) do
  WaitUtility.wait_untill_elements_size_steadied
  next_delete = true
  
  while next_delete
    WaitUtility.wait_untill_elements_size_steadied
    
    begin
      @page_object.tasksPage.firstTitle_element.click
      WaitUtility.wait_untill_elements_size_steadied
      @page_object.tasksPage.deleteTask_element.when_visible(TIME_OUT_LIMIT).click
      @page_object.tasksPage.yesDeleteTask_element.when_visible(TIME_OUT_LIMIT).click
    rescue Exception => e
      next_delete = false
    end
    
  end

  @page_object.tasksPage.completeStatus_element.click

  WaitUtility.wait_untill_elements_size_steadied
  next_delete = true
  
  while next_delete
    WaitUtility.wait_untill_elements_size_steadied
    
    begin
      @page_object.tasksPage.firstTitle_element.click
      WaitUtility.wait_untill_elements_size_steadied
      @page_object.tasksPage.deleteTask_element.when_visible(TIME_OUT_LIMIT).click
      @page_object.tasksPage.yesDeleteTask_element.when_visible(TIME_OUT_LIMIT).click
    rescue Exception => e
      next_delete = false
    end
    
  end
  @page_object.tasksPage.activeStatus_element.click
end

# #display ------------------

Then(/^the system should be displayed below info\. under Tasks section$/) do |table|
  WaitUtility.wait_untill_elements_size_steadied

  note_content = @page_object.tasksPage.containerList_element.when_visible(TIME_OUT_LIMIT).text

  table.rows.each do |expect_result, k|
    if expect_result.downcase == "calendar"
      expect(@page_object.tasksPage.calendarList_element.visible?).to eq(true),"The calendar did not displayed!"
    else
      expect(note_content.include? expect_result).to eq(true), "It was looking for: #{expect_result}\ngot: #{note_content} "
    end
  end
  
end

Then(/^the system should be displayed below info\. under Create Task section$/) do |table|
  WaitUtility.wait_untill_elements_size_steadied

  @page_object.tasksPage.containerEdit_element.text
  note_content = @page_object.tasksPage.containerEdit_element.when_visible(TIME_OUT_LIMIT).text

  table.rows.each do |expect_result, k|
    if expect_result.downcase == "calendar"
      expect(@page_object.tasksPage.calendarEdit_element.visible?).to eq(true),"The calendar did not displayed!"
    else
      expect(note_content.include? expect_result).to eq(true), "It was looking for: #{expect_result}\ngot: #{note_content} "
    end
  end
  
end

When(/^the system will be displayed above task info in edit mode$/) do
  WaitUtility.wait_untill_elements_size_steadied
  expect(@page_object.tasksPage.titleTask).to eq(@table_hash["Title"])
  expect(@page_object.tasksPage.bodyTask).to eq(@table_hash["Description"])

  on_due_date = @page_object.tasksPage.onDueDate_checked?
  expect(on_due_date.to_s).to eq(@table_hash["On the Due Date"]), "On the Due Date:\nexpected: #{on_due_date.to_s}\ngot: #{@table_hash["On the Due Date"]}"
  
  day_before_due_date = false
  if @table_hash["Day before due date"].to_i > 0
    day_before_due_date = true 
    expect(@page_object.tasksPage.daysPrior_element.text).to eq(@table_hash["Day before due date"])
  end
  
  before_due = @page_object.tasksPage.beforeDue_checked?
  expect(before_due.to_s).to eq(day_before_due_date.to_s), "Day before due date:\nexpected: #{before_due}\ngot: #{day_before_due_date}"
  
  
  by_email = @page_object.tasksPage.byEmail_checked?
  expect(by_email.to_s).to eq(@table_hash["By Email"]), "By Email:\nexpected: #{by_email.to_s}\ngot: #{@table_hash["By Email"]}"
  
  by_text = @page_object.tasksPage.byText_checked?
  expect(by_text.to_s).to eq(@table_hash["By text"]), "By text:\nexpected: #{by_text.to_s}\ngot: #{@table_hash["By text"]}"

  expect(@page_object.tasksPage.saveTask_element.enabled?).to eq(false), "the save button would be disabled"  
end

When(/^the system will be displayed the creation task info by ignore the change$/) do
  WaitUtility.wait_untill_elements_size_steadied
  expect(@page_object.tasksPage.titleTask).to eq(@table_hash["Title"])
  expect(@page_object.tasksPage.bodyTask).to eq(@table_hash["Description"])

  on_due_date = @page_object.tasksPage.onDueDate_checked?
  expect(on_due_date.to_s).to eq(@table_hash["On the Due Date"]), "On the Due Date:\nexpected: #{on_due_date.to_s}\ngot: #{@table_hash["On the Due Date"]}"
  
  day_before_due_date = false
  if @table_hash["Day before due date"].to_i > 0
    day_before_due_date = true 
    expect(@page_object.tasksPage.daysPrior_element.text).to eq(@table_hash["Day before due date"])
  end
  
  before_due = @page_object.tasksPage.beforeDue_checked?
  expect(before_due.to_s).to eq(day_before_due_date.to_s), "Day before due date:\nexpected: #{before_due}\ngot: #{day_before_due_date}"
  
  
  by_email = @page_object.tasksPage.byEmail_checked?
  expect(by_email.to_s).to eq(@table_hash["By Email"]), "By Email:\nexpected: #{by_email.to_s}\ngot: #{@table_hash["By Email"]}"
  
  by_text = @page_object.tasksPage.byText_checked?
  expect(by_text.to_s).to eq(@table_hash["By text"]), "By text:\nexpected: #{by_text.to_s}\ngot: #{@table_hash["By text"]}"

  expect(@page_object.tasksPage.saveTask_element.enabled?).to eq(false), "the save button would be disabled"  
end

# Then(/^the system should be displayed below title$/) do |table|
#   WaitUtility.wait_untill_elements_size_steadied
#   note_content = @page_object.tasksPage.noteTable_element.when_visible(TIME_OUT_LIMIT).text
  
#    table.rows.each do |key, v|
#     expect(note_content.include? key).to eq(true), "It was looking for: #{key}\ngot: #{note_content}"
#    end
# end

# Then(/^the user visit Academic page and return back$/) do
#   WaitUtility.wait_untill_elements_size_steadied
#   @page_object.tasksPage.academic_element.when_visible(TIME_OUT_LIMIT).click
#   WaitUtility.wait_untill_elements_size_steadied
#   @page_object.tasksPage.notes_element.when_visible(TIME_OUT_LIMIT).click
#   WaitUtility.wait_untill_elements_size_steadied
# end

# Then(/^the user visit Description page and return back$/) do
#   WaitUtility.wait_untill_elements_size_steadied
#   @page_object.tasksPage.description_element.when_visible(TIME_OUT_LIMIT).click
#   WaitUtility.wait_untill_elements_size_steadied
#   @page_object.tasksPage.notes_element.when_visible(TIME_OUT_LIMIT).click
#   WaitUtility.wait_untill_elements_size_steadied
# end

Then(/^the system will be displayed title and due date based on above info under tasks$/) do
  WaitUtility.wait_untill_elements_size_steadied

  note_content = @page_object.tasksPage.containerList_element.when_visible(TIME_OUT_LIMIT).text
  note_content = note_content.split("Reminder")[1]
  expect(note_content.include? @table_hash["Title"]).to eq(true),"It was looking for: #{@table_hash["Title"]}\ngot: #{note_content}"
  
  due_date = @due_date.strftime("%b") + " " + @due_date.day.to_s
   
  expect(note_content.include? due_date).to eq(true), "It was looking for: #{due_date}\ngot: #{note_content}"
end

Then(/^the system should not display title and due date based on above info under tasks$/) do
  WaitUtility.wait_untill_elements_size_steadied

  note_content = @page_object.tasksPage.containerList_element.when_visible(TIME_OUT_LIMIT).text
  note_content = note_content.split("Reminder")[1]
  expect(note_content.include? @table_hash["Title"]).to eq(false),"It should not find: #{@table_hash["Title"]}\n in: #{note_content}"
  
  due_date = @due_date.strftime("%b") + " " + @due_date.day.to_s
   
  expect(note_content.include? due_date).to eq(false), "It should not find: #{due_date}\n in: #{note_content}"
end

# Then(/^the user should loss the note data$/) do
#   expect(@page_object.tasksPage.titleNote).to eq ""
#   expect(@page_object.tasksPage.bodyNote).to eq ""
# end

When(/^the user mouse hover over task title$/) do
  fail "Write code here that turns the phrase above into concrete actions"
end

Then(/^the system will be display "([^"]*)"$/) do |arg1|
  fail "Write code here that turns the phrase above into concrete actions"
end

When(/^the user mouse hover over check box close to task title$/) do
  fail "Write code here that turns the phrase above into concrete actions"
end

When(/^the user select the check box close to task title$/) do
  fail "Write code here that turns the phrase above into concrete actions"
end

Then(/^the system display "([^"]*)" buttons$/) do |arg1|
  fail "Write code here that turns the phrase above into concrete actions"
end

# ------------------------------

def table_hash(table)
  table_hash = {}
  table.rows.each do |key, value|
     table_hash[key] = value
  end
  return table_hash
end

def enter_due_date()
  WaitUtility.wait_untill_elements_size_steadied
  date = @table_hash['Due date']
  date = date.split("+")
  day_plus = 0
  month_plus = 0
  year_plus = 0
  
  date.each do |k|
    k = k.downcase
    if k == 'today'
    elsif k.include? "d"
      day_plus = k.split("d")[0].to_i
    elsif  k.include? "m" 
      month_plus = k.split("m")[0].to_i 
    elsif k.include? "y"
      year_plus = k.split("y")[0].to_i
    end
     
  end
  date = DateTime.now + day_plus
  date = date >> month_plus
  date = date >> year_plus * 12
  @due_date = date
  
  year = date.year
  month = date.month
  day = date.day.to_s
  
  set_month_year(month, year)
  set_day(day)
end

def set_month_year(month, year)
  WaitUtility.wait_untill_elements_size_steadied
  month_year_text = @page_object.tasksPage.yearText_element.text
  month_year_text = month_year_text.split(" ")
  month_text = month_year_text[0]
  year_text = month_year_text[1]

  set_month(month, month_text)
  set_year(year, year_text.to_i)
end

def set_month(month, month_text)
  month_text_value = get_month(month_text)
  
  month_index = month - month_text_value.to_i
  index = month_index
  month_index = month_index * -1 if index < 0

  for i in 0..month_index-1
    @page_object.tasksPage.yearRightStart_element.click if index > 0 
    @page_object.tasksPage.yearLeftStart_element.click if index < 0 
  end
end

def set_year(year, year_text_value)
  year_index = year - year_text_value
  index = year_index
  year_index = year_index * -1 if index < 0

  for i in 1..year_index * 12
    @page_object.tasksPage.yearRightStart_element.click if index > 0 
    @page_object.tasksPage.yearLeftStart_element.click if index < 0 
  end
end

def set_day(day)
  day = "0" + day if day.size < 2
  day_ele = BROWSER.element(:text, day)
  day_ele.click
end

def set_day_before_due_date()
  WaitUtility.wait_untill_elements_size_steadied
  @page_object.tasksPage.beforeDue_element.click unless @page_object.tasksPage.beforeDue_checked?

  WaitUtility.wait_untill_elements_size_steadied
  @page_object.tasksPage.daysPrior_element.text
  days_prior = @page_object.tasksPage.daysPrior_element.text.to_i
  
  days_prior_index = @table_hash["Day before due date"].to_i - days_prior
  index = days_prior_index
  days_prior_index = days_prior_index * -1 if index < 0
  
  if index > 1
    for i in 1..days_prior_index
      @page_object.tasksPage.iconPlus_element.click 
    end
  else
    for i in 1..days_prior_index
      @page_object.tasksPage.iconMinus_element.click 
    end
  end
end

def get_month(date_text)
  case date_text.downcase
    when "january"
      date = '01'
    when "february"
      date = '02'
    when "march"
      date = '03'
    when "april"
      date = '04'
    when "may"
      date = '05'
    when "june"
      date = '06'
    when "july"
      date = '07'
    when "august"
      date = '08'
    when "september"
      date = '09'
    when "october"
      date = '10'
    when "november"
      date = '11'
    when "december"
      date = '12'
    end
return date
end

