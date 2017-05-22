class ProfilePage
  include PageObject

  page_url('/profile/view')

  # Profile----------
  # General ------
  div(:errorDiv, :css => '#login-error')
  button(:cancel, :text => 'Cancel')
  button(:save, :text => 'Save')
  h1(:title, :text => "Profile")

  # link(:aboutMe, :css => '[href="/profile/about-me"]')
  link(:aboutMe, :css => ".col-xs-12.col-sm-3.col-lg-2 li a")
  link(:contact, :css => '[href="/profile/contact"]')
  # link(:settings, :text => 'Settings')
  # link(:settings, :css => '[href="/profile/settings"]')
  link(:payment, :css => ".col-xs-12.col-sm-3.col-lg-2 li ~li ~li a")
  link(:settings, :css => ".col-xs-12.col-sm-3.col-lg-2 li ~li ~li ~li a")
  link(:education, :css => '[href="/profile/education"]')
  link(:courses, :css => '[href="/profile/courses"]')
  link(:tests, :css => '[href="/profile/tests"]')
  link(:activities, :css => '[href="/profile/activities"]')
  link(:achievements, :css => '[href="/profile/achievements"]')

  div(:profileContainer, :css =>'.row.content')
  
  # About me----------
  text_field(:firstName, :css => '#first-name')
  text_field(:lastName, :css => '#last-name')

  radio_button(:freshman, :css => '#freshman')
  radio_button(:sophomore, :css => '#sophomore')
  radio_button(:junior, :css => '#junior')
  radio_button(:senior, :css => '#senior')

  radio_button(:female, :id => 'female')
  radio_button(:male, :id => 'male')

  select_list(:birthMonth, :id => 'birth-month')
  select_list(:birthDay, :id => 'birth-day')
  select_list(:birthYear, :id => 'birth-year')

  # select_list(:citizenship, :id => 'citizenship')
  div(:citizenship, :css => '.below')
  text_field(:citizenshipInput, :css =>'.filter input')
  select_list(:ethnicity, :id => 'ethnicity')
  select_list(:race, :id => 'race')

  # Contact-----------------
  text_field(:email, :css => '#email')
  text_field(:phone, :css => '#phone')
  text_field(:parentEmail, :css => '#parent-email')
  text_field(:address1, :css => '#address-1')
  text_field(:address2, :css => '#address-2')
  text_field(:city, :css => '#city')
  select_list(:state, :css => '#state')
  text_field(:zip, :css => '#zip')
  
  # Setting --------
  label(:emailNotifications, :css => "[name='email'] label")
  label(:webNotifications, :css => "[name='web'] label")
  
  radio_button(:webDaily, :css => '#web-daily')
  radio_button(:webWeekly, :css => '#web-weekly')
  radio_button(:webMonthly, :css => '#web-monthly')

  label(:textNotifications, :css => "[name='text'] label")
  label(:marketingEmails, :css => "[name='marketing'] label")

  radio_button(:marketingDaily, :css => '#marketing-daily')
  radio_button(:marketingWeekly, :css => '#marketing-weekly')
  radio_button(:marketingMonthly, :css => '#marketing-monthly')

  text_field(:currentPassword, :css => '#current')
  text_field(:newPassword, :css => '#new')
  text_field(:reTypeNewPassword, :css => '#confirm')

  button(:updatePassword, :css => '.btn.btn-primary')
  
  # Education ------
  button(:addItem, :css => '.btn.btn-sm.btn-default')

  text_field(:schoolName, :id => 'high-school')

  radio_button(:yesGrad, :css => '#yes-grad')
  radio_button(:noGrad, :css => '#no-grad')

  text_field(:startDate, :css => '#Start-Date')
  text_field(:graduationDate, :css => '#Graduation-Date')
  text_field(:endDate, :css => '#End-Date')
  link(:startCross, :css => '[label="Start Date"] a')
  link(:graduationCross, :css => '.col-sm-4 ~ .col-sm-4 a')

  text_field(:uwGpa, :css => '#uw-gpa')
  text_field(:wGpa, :css => '#w-gpa')
  text_field(:tWGpa, :css => '#total-gpa')

  #date table --------
  table(:dateTableStart, :css => "[role='grid']")
  strong(:yearTextStart, :css => '.mt5 strong')
  button(:yearRightStart, :css => '.btn.btn-link.pull-right')                        
  button(:yearLeftStart, :css => '.pull-left')

  
  table(:dateTableGard, :css => ".col-sm-4 ~ .col-sm-4 [role='grid']")
  strong(:yearTextGrad, :css => '.col-sm-4 ~ .col-sm-4 .mt5 strong')
  button(:yearRightGrad, :css => '.col-sm-4 ~ .col-sm-4 .calendar .pull-right')                        
  button(:yearLeftGrad, :css => '.col-sm-4 ~ .col-sm-4 .pull-left')

  table(:dateTableEnd, :css => ".col-sm-4 ~ .col-sm-4 ~ [role='grid']")
  strong(:yearTextEnd, :css => '.col-sm-4 ~ .col-sm-4 .mt5 strong')
  button(:yearRightEnd, :css => '.col-sm-4 ~ .col-sm-4 .calendar .pull-right')                       
  button(:yearLeftEnd, :css => '.col-sm-4 ~ .col-sm-4 .pull-left')

  i(:edit, :css => '.icon.icon-new-message')
  button(:cancel, :text => 'Cancel')
  
  button(:delete, :css => '.btn.btn-link.delete')
  button(:yesDelete, :text => 'Yes, delete')
  button(:cancelDelete, :css => '.btn.btn-sm.btn-danger-invert')

  # Course ---------------
  text_field(:courseName, :css => '#course-name')

  select_list(:courseType, :css => '#course-type')
  select_list(:courseLevel, :css => '#course-level')
  select_list(:highestLevel, :css => '#highest-level')
  select_list(:gradingMethod, :css => '#grading-method')

  text_field(:finalGrade, :css => '#final-grade')

  # Tests -------------------
  select_list(:testType, :css => '#test-type')
  select_list(:testSubject, :css => '#test-subject')

  text_field(:testDate, :css => '#Test-Date')
  text_field(:scoreTest, :css => '#score')

  div(:ibSubject, :css => '.single')
  div(:ibOptions, :css => '.options')
  
  # Activities ----------------
  text_field(:activityName, :css => '#activity-title')
  select_list(:activityType, :css => '#activity-type')

  checkbox(:freshmanDo, :css => '#freshman')
  checkbox(:sophomoreDo, :css => '#sophomore')
  checkbox(:juniorDo, :css => '#junior')
  checkbox(:seniorDo, :css => '#senior')

  radio_button(:duringSchool, :css => '#during-school')
  radio_button(:overBreaks, :css => '#over-breaks')
  radio_button(:allYear, :css => '#all-year')
  
  radio_button(:totalHours, :css => '#total')
  radio_button(:perWeekHours, :css => '#per-week')
  
  text_field(:hours, :css => '#total-hours')
  text_field(:hoursPerWeek, :css => '#hours-per-week')
  text_field(:weeksPerYear, :css => '#weeks-per-year')

  textarea(:description, :css => '#act-des')
  
  # Achievements ---------------
  text_field(:achieveTitle, :css => '#achieve-title')

  checkbox(:achHs, :css => '#ach-hs')
  checkbox(:achLoc, :css => '#ach-loc')
  checkbox(:achDist, :css => '#ach-dist')
  checkbox(:achState, :css => '#ach-state')
  checkbox(:achNat, :css => '#ach-nat')
  checkbox(:achInt, :css => '#act-int')

  textarea(:achieveDescription, :css => '#ach-des')
end

