Feature: The user with an account should be able to save activities data

  Background: The user with an account 
    Given the user is registered and stay login
      | key              | Value           |
      | First name       | Jem             |
      | Last name        | Dell            |
      | Email address    | activity@t.com     |
      | Birth Month      | June            |
      | Birth Day        | 22              |
      | Birth Year       | 2001            |
      | Password         | Test123456      |
      | Confirm Password | Test123456      |
      | TOS CheckBox     | True            |
    And the user select Profile from drop down


  @smoke_test
  Scenario: the system should provide below info under activities section
    When the user select "Activities" from Profile section
    And the user delete all Profile data record
    Then the system will display below information under profile section
      """
      Add another activity
      You have no activities saved. Click the button above to add one 
      """

    When the user select Add another activity
    Then the system will display below information under profile section
      """
       Name of Activity
      Type of Activity
        select
        Academic
        Art
        Athletic Varsity
        Athletic Jr. Varsity
        Club/Organization
        Family Responsibility
        Internship
        JROTC
        Volunteer
        Work
        Other
      What grade did you do this? Select multiple if applicable.
        Freshman
        9th grade
        Sophomore
        10th grade
        Junior
        11th grade
        Senior
        12th grade
      When did you participate in this activity?
        During School
        Over breaks (e.g., summer)
        All year
      Hours
        Total
        Per Week
      Hours
      Description
      Save
      Cancel
      """
      

  Scenario: the Save button should be disable until the user enter all required fields
    When the user select "Activities" from Profile section
    And the user select Add another activity
    Then the Save button would be disable until the user enter all activity required fields
      | key              | Value                                          |
      | Name of Activity | public library                                 |
      | Type of Activity | Volunteer                                      |
      | Grade            | Freshman                                       |
      | Participate      | Over breaks                                    |
      | Hours            | Total=100                                      |
      | Description      | Deliver and pick up library items as requested |
    
  


  Scenario: The user should be able to disregard the activity by visiting another page without saving
    When the user select "Activities" from Profile section
    And the user delete all Profile data record
    And the user enter the activity data
      | key              | Value                                          |
      | Name of Activity | public library                                 |
      | Type of Activity | Volunteer                                      |
      | Grade            | Freshman                                       |
      | Participate      | Over breaks                                    |
      | Hours            | Hours per week=10; Weeks per year=30           |
      | Description      | Deliver and pick up library items as requested |
      
     
    Then the user will loss the above activity info if navigate to "Tests" page before saving the data
    


  Scenario: The user should be able to enter and save activity info
    When the user select "Activities" from Profile section
    And the user delete all Profile data record
    And the user enter the activity data
      | key              | Value                                          |
      | Name of Activity | public library                                 |
      | Type of Activity | Volunteer                                      |
      | Grade            | Freshman; Sophomore                            |
      | Participate      | Over breaks                                    |
      | Hours            | Hours per week=10; Weeks per year=30           |
      | Description      | Deliver and pick up library items as requested |
    
    And the profile Save button will be enable
    And the user save the information
    Then the user will not loss the above activity info if visit "Tests" page


  @regression
  Scenario: The user should be able to edit and save an existing activity info
    When the user select "Activities" from Profile section
    And the user delete all Profile data record
    And the user enter the activity data
      | key              | Value                                          |
      | Name of Activity | public library                                 |
      | Type of Activity | Volunteer                                      |
      | Grade            |                                                |
      | Participate      | Over breaks                                    |
      | Hours            | Hours per week=10; Weeks per year=30           |
      | Description      | Deliver and pick up library items as requested |
    
    And the user save the information 

    When the user edit the activity info
      | key              | Value            |
      | Name of Activity | Soccer           |
      | Type of Activity | Athletic Varsity |
      | Grade            | Junior; Senior   |
      | Participate      | All year         |
      | Hours            | Total=100        |
      | Description      | Sport Activity   |
    
    And the user save the information
    Then the user will not loss the above modification activity


  Scenario: The user should be able to disregard the modification on an existing activity info
    When the user select "Activities" from Profile section
    And the user delete all Profile data record
    And the user enter the activity data
      | key              | Value            |
      | Name of Activity | Soccer           |
      | Type of Activity | Athletic Varsity |
      | Grade            | Junior; Senior   |
      | Participate      | All year         |
      | Hours            | Total=100        |
      | Description      | Sport Activity   |
    
    
    And the user save the information

    When the user edit the activity info
      | key              | Value                                          |
      | Name of Activity | public library                                 |
      | Type of Activity | Volunteer                                      |
      | Grade            |                                                |
      | Participate      | Over breaks                                    |
      | Hours            | Hours per week=10; Weeks per year=30           |
      | Description      | Deliver and pick up library items as requested |
    
    And the user cancel the modification
    Then the user will disregard the above modification activity


  @regression
  Scenario: The user should be able to delete or disregard the delete of an existing activity info
    When the user select "Activities" from Profile section
    And the user delete all Profile data record
    And the user enter the activity data
      | key              | Value            |
      | Name of Activity | Soccer           |
      | Type of Activity | Athletic Varsity |
      | Grade            | Junior; Senior   |
      | Participate      | All year         |
      | Hours            | Total=100        |
      | Description      | Sport Activity   |
    
    And the user save the information
    And the user select edit course

    When the user select Delete school
    And the user disregard the deletion 
    Then the activity record will be displayed 

    When the user select Delete school
    And the user confirm the deletion   
    Then the activity record will be removed
    And the user should be able to logout  
    
