Feature: The system will provide the user Notes option with schools, majors and occupations


  Background: 
    Given the user A register and stay login  
        | key              | Value           |
        | First name       | Jem             |
        | Last name        | Dell            |
        | Email address    | tasks@gmail.com |
        | Birth Month      | June            |
        | Birth Day        | 22              |
        | Birth Year       | 2001            |
        | Password         | Test123456      |
        | Confirm Password | Test123456      |
        | TOS CheckBox     | True            |
    And the user from Home Page navigate to Tasks Page
    And the user delete all existing tasks

  
  @smoke_test
  Scenario: the system should provide tasks option for user with an account
    When the user select "Active" task status
    Then the system should be displayed below info. under Tasks section
      | active section         |
      | Tasks                  |
      | Status:                |
      | Active                 |
      | Complete               |
      | Create task            |
      | Title                  |
      | Due Date               |
      | Reminder               |
      | Create your first task |
      | Calendar               |
      

    When the user select "Complete" task status
    Then the system should be displayed below info. under Tasks section
      | Complete section  |
      | Tasks             |
      | Status:           |
      | Active            |
      | Complete          |
      | Create task       |
      | Title             |
      | Due Date          |
      | Reminder          |
      | Calendar          |
      
      

  @smoke_test
  Scenario: the user should have option to create a task
    When the user select "Active" task status
    And the user select "Create task" from tasks page
    Then the system should be displayed below info. under Create Task section
      | create section                          |
      | Create Task                             |
      | Due date                                |
      | Click date to set                       |
      | Save                                    |
      | Cancel                                  |
      | Remind me (optional)                    |
      | Select a Due Date to activate reminders |
      | Calendar                                |

    And the save task button would be disabled
    And the cancel task button would be enabled
      

  
  Scenario: the user should be able to create a task
    When the user select "Active" task status
    And the user select "Create task" from tasks page
    And the user add and save task
      | key                 | value          |
      | Title               | Task title     |
      | Description         | Task body      |
      | Due date            | today+3d+1m+0y |
      | On the Due Date     | false          |
      | Day before due date | 0              |
      | By Email            | false          |
      | By text             | false          |
      | Phone number        | (703) 456-7645 |

    Then the system will be displayed title and due date based on above info under tasks


  Scenario: the edit mode data matches with the data in the creation mode
    When the user select "Active" task status
    And the user select "Create task" from tasks page
    And the user add and save task
      | key                 | value          |
      | Title               | Task title     |
      | Description         | Task body      |
      | Due date            | today+3d+1m+0y |
      | On the Due Date     | true           |
      | Day before due date | 2              |
      | By Email            | true           |
      | By text             | true           |
      | Phone number        | (703) 456-7645 |

    Then the system will be displayed title and due date based on above info under tasks

    When the user open the existing task in edit mode
    Then the system will be displayed above task info in edit mode 


  Scenario: the user should be able to edit the existing task 
    When the user select "Active" task status
    And the user select "Create task" from tasks page
    And the user add and save task
      | key                 | value          |
      | Title               | Task title     |
      | Description         | Task body      |
      | Due date            | today+3d+0m+0y |
      | On the Due Date     | false          |
      | Day before due date | 4              |
      | By Email            | false          |
      | By text             | false          |
      | Phone number        | (703) 456-7645 |

    Then the system will be displayed title and due date based on above info under tasks

    When the user open the existing task in edit mode
    And the user edit and save task
      | key                 | value          |
      | Title               | Task title1    |
      | Description         | Task body1     |
      | Due date            | today+4d+0m+0y |
      | On the Due Date     | true           |
      | Day before due date | 2              |
      | By Email            | true           |
      | By text             | true           |
      | Phone number        | (703) 456-7645 |
    And the user open the existing task in edit mode
    
    Then the system will be displayed above task info in edit mode



  Scenario: the user should be able to edit the existing task - edit the Day before due date 
    When the user select "Active" task status
    And the user select "Create task" from tasks page
    And the user add and save task
      | key                 | value          |
      | Title               | Task title     |
      | Description         | Task body      |
      | Due date            | today+3d+0m+0y |
      | On the Due Date     | false          |
      | Day before due date | 2              |
      | By Email            | false          |
      | By text             | false          |
      | Phone number        | (703) 456-7645 |

    Then the system will be displayed title and due date based on above info under tasks

    When the user open the existing task in edit mode
    And the user updates the Day before due date to "4" 
    Then the save task button would be enabled

  
  Scenario: the user should NOT be able to set reminder date before creation date
    When the user select "Active" task status
    And the user select "Create task" from tasks page
    And the user add and save task
      | key                 | value          |
      | Title               | Task title     |
      | Description         | Task body      |
      | Due date            | today+1d+0m+0y |
      | On the Due Date     | false          |
      | Day before due date | 3              |
      | By Email            | false          |
      | By text             | false          |
      | Phone number        | (703) 456-7645 |

    Then the system should not display title and due date based on above info under tasks


  Scenario: the user should be able to ignore the change 
    When the user select "Active" task status
    And the user select "Create task" from tasks page
    And the user add and save task
      | key                 | value          |
      | Title               | Task title     |
      | Description         | Task body      |
      | Due date            | today+3d+0m+0y |
      | On the Due Date     | false          |
      | Day before due date | 4              |
      | By Email            | false          |
      | By text             | false          |
      | Phone number        | (703) 456-7645 |

    Then the system will be displayed title and due date based on above info under tasks

    When the user open the existing task in edit mode
    And the user edit and cancel the change
      | key                 | value          |
      | Title               | Task title1    |
      | Description         | Task body1     |
      | Due date            | today+4d+0m+0y |
      | On the Due Date     | true           |
      | Day before due date | 2              |
      | By Email            | true           |
      | By text             | true           |
      | Phone number        | (703) 456-7645 |
    And the user open the existing task in edit mode
    
    Then the system will be displayed the creation task info by ignore the change
     

  Scenario: the user should be able to delete a task
    When the user select "Active" task status
    And the user select "Create task" from tasks page
    And the user add and save task
      | key                 | value          |
      | Title               | Task title     |
      | Description         | Task body      |
      | Due date            | today+3d+0m+0y |
      | On the Due Date     | false          |
      | Day before due date | 4              |
      | By Email            | false          |
      | By text             | false          |
      | Phone number        | (703) 456-7645 |

    Then the system will be displayed title and due date based on above info under tasks

    When the user open the existing task in edit mode
    And the user delete the task and confirmed  

    Then the system should not display title and due date based on above info under tasks


  Scenario: the user should be able to ignore deleting a task
    When the user select "Active" task status
    And the user select "Create task" from tasks page
    And the user add and save task
      | key                 | value          |
      | Title               | Task title     |
      | Description         | Task body      |
      | Due date            | today+3d+0m+0y |
      | On the Due Date     | false          |
      | Day before due date | 4              |
      | By Email            | false          |
      | By text             | false          |
      | Phone number        | (703) 456-7645 |

    Then the system will be displayed title and due date based on above info under tasks

    When the user open the existing task in edit mode
    And the user delete the task but did not confirm

    Then the system will be displayed above task info in edit mode



  Scenario: the system by default should check remind me on the due date when by email or text selected 
    When the user select "Active" task status
    And the user select "Create task" from tasks page
    And the user add and save task
      | key                 | value          |
      | Title               | Task title     |
      | Description         | Task body      |
      | Due date            | today+3d+0m+0y |
      | On the Due Date     | false          |
      | Day before due date | 0              |
      | By Email            | true           |
      | By text             | false          |
      | Phone number        | (703) 456-7645 |

    When the user open the existing task in edit mode
    Then the remind me on the due date check box will be checked

    When the user unchecked the check box for by email
    Then the remind me on the due date check box will be unchecked

    When the user checked the check box for by text
    Then the remind me on the due date check box will be checked

    When the user unchecked the check box for by text
    Then the remind me on the due date check box will be unchecked 

    When the user checked the check box for by text
    And the user unchecked the check box for remind me on the due date
    Then the save task button would be disabled

    
  Scenario: the system should inform the user how to edit, delete and complete the task
    When the user mouse hover over task title
    Then the system will be display "click to edit or delete the task"

    When the user mouse hover over check box close to task title
    Then the system will be display "click to complete the task"

#   OR
    When the user select the check box close to task title
    Then the system display "complete, edit, delete" buttons 
  


  Scenario: the user should have option to check the task as Complete or Incomplete after been created 
    When the user select "Active" task status
    And the user select "Create task" from tasks page
    And the user add and save task
      | key                 | value          |
      | Title               | Task title     |
      | Description         | Task body      |
      | Due date            | today+3d+0m+0y |
      | On the Due Date     | false          |
      | Day before due date | 0              |
      | By Email            | true           |
      | By text             | false          |
      | Phone number        | (703) 456-7645 |

    Then the system will be displayed title and due date based on above info under tasks

    When the user check the task as complete
    Then the system should not display title and due date based on above info under tasks

    When the user select "Complete" task status
    Then the system will be displayed title and due date based on above info under tasks

    When the user open the existing task in edit mode
    And the user click on Compelete Task button
    And the user click on cancel button
    Then the system should not display title and due date based on above info under tasks

    When the user select "Active" task status
    Then the system will be displayed title and due date based on above info under tasks


  Scenario: the user should be able to edit the complete task
    When the user select "Active" task status
    And the user select "Create task" from tasks page
    And the user add and save task
      | key                 | value          |
      | Title               | Task title     |
      | Description         | Task body      |
      | Due date            | today+3d+0m+0y |
      | On the Due Date     | false          |
      | Day before due date | 4              |
      | By Email            | false          |
      | By text             | false          |
      | Phone number        | (703) 456-7645 |

    Then the system will be displayed title and due date based on above info under tasks

    When the user check the task as complete
    And the user select "Complete" task status
    And the user open the existing task in edit mode
    And the user edit and save task
      | key                 | value          |
      | Title               | Task title1    |
      | Description         | Task body1     |
      | Due date            | today+4d+0m+0y |
      | On the Due Date     | true           |
      | Day before due date | 2              |
      | By Email            | true           |
      | By text             | true           |
      | Phone number        | (703) 456-7645 |
    And the user open the existing task in edit mode
    
    Then the system will be displayed above task info in edit mode


  Scenario: the user should be able to delete the complete task
    When the user select "Active" task status
    And the user select "Create task" from tasks page
    And the user add and save task
      | key                 | value          |
      | Title               | Task title     |
      | Description         | Task body      |
      | Due date            | today+3d+0m+0y |
      | On the Due Date     | false          |
      | Day before due date | 4              |
      | By Email            | false          |
      | By text             | false          |
      | Phone number        | (703) 456-7645 |

    Then the system will be displayed title and due date based on above info under tasks

    When the user check the task as complete
    And the user select "Complete" task status
    And the user open the existing task in edit mode
    And the user delete the task and confirmed  

    Then the system should not display title and due date based on above info under tasks


  Scenario: the user should be able to save the change of the complete task to incomplete
    When the user select "Active" task status
    And the user select "Create task" from tasks page
    And the user add and save task
      | key                 | value          |
      | Title               | Task title     |
      | Description         | Task body      |
      | Due date            | today+3d+0m+0y |
      | On the Due Date     | false          |
      | Day before due date | 0              |
      | By Email            | true           |
      | By text             | false          |
      | Phone number        | (703) 456-7645 |

    Then the system will be displayed title and due date based on above info under tasks

    When the user open the existing task in edit mode
    And the user click on Compelete Task button
    Then the save task button would be enabled






