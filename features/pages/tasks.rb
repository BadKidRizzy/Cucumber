class TasksPage
  include PageObject

  page_url('/tasks')
  
  h1(:title, :text => 'Tasks')
  link(:activeStatus, :text => "Active")
  link(:completeStatus, :text => "Complete")
  
  button(:createTask, :text => 'Create task')
  button(:createFirstTask, :text => 'Create your first task')

  div(:containerList, :css => 'tasks-list-page .container')
  div(:calendarList, :css => '.calendar.list')

  

  div(:firstTitle, :css => '.task-title')
  checkbox(:firstComplete, :id =>'checkbox-0')

  button(:completeTask, :text =>'Complete Task')

  #Create ---------------------
  div(:containerEdit, :css => 'task-edit-page .container')
  div(:calendarEdit, :css => '.calendar.edit')

  button(:deleteTask, :text => 'Delete Task')
  button(:yesDeleteTask, :css => '.del.row .delete-btn')
  button(:cancelDeleteTask, :css => '.del.row .btn-danger-invert')

  button(:saveTask, :text => 'Save')
  button(:cancelTask, :text => 'Cancel')


  text_field(:titleTask, :name => 'title')
  textarea(:bodyTask, :name => 'descript')
  checkbox(:onDueDate, :id =>'on-due-date')
  checkbox(:beforeDue, :name =>'before-due')

  i(:iconPlus, :css =>'.icon-plus')
  i(:iconMinus, :css =>'.icon-minus')
  strong(:daysPrior, :css => '.days-prior')

  checkbox(:byEmail, :id =>'by-email')
  checkbox(:byText, :id =>'by-text')
  text_field(:phoneText, :id => 'phone')
  button(:savePhone, :text => 'Save number')

  button(:yearText, :id => /datepicker/)
  button(:yearRightStart, :css => '.btn.btn-default.btn-sm.pull-right')                        
  button(:yearLeftStart, :css => '.pull-left')

end