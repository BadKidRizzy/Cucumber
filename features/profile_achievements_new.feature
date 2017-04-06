Feature: The user with an account should be able to save achievements data

  Background: The user with an account 
    Given the user is registered and stay login
      | key              | Value           |
      | First name       | Jem             |
      | Last name        | Dell            |
      | Email address    | achievement@t.com     |
      | Birth Month      | June            |
      | Birth Day        | 22              |
      | Birth Year       | 2001            |
      | Password         | Test123456      |
      | Confirm Password | Test123456      |
      | TOS CheckBox     | True            |
    And the user select Profile from drop down


  @smoke_test
  Scenario: the system should provide below info under achievements section
    When the user select "Achievements" from Profile section
    And the user delete all Profile data record
    Then the system will display below information under profile section
      """
      Add another achievement
      You have no achievements saved. Click the button above to add one 
      """

    When the user select Add another achievement
    Then the system will display below information under profile section
      """
        Title of Achievement
        At what level were you recognized for this achievement? Select multiple if applicable.
          High School
          Local
          District
          State or Regional
          National
          International
        What grade did you do this activity? Select multiple if applicable.
          Freshman
          9th grade
          Sophomore
          10th grade
          Junior
          11th grade
          Senior
          12th grade
        Description
        Save
        Cancel
      """
      

  Scenario: the Save button should be disable until the user enter all required fields
    When the user select "Achievements" from Profile section
    And the user select Add another achievement
    Then the Save button would be disable until the user enter all achievement required fields
      | key                  | Value              |
      | Title of Achievement | Best Soccer player |
      | Level of Achievement | District;National  |
      | Grade Level          | Junior;Senior      |
      | Description          | High School Team   |
    
  


  Scenario: The user should be able to disregard the achievement by visiting another page without saving
    When the user select "Achievements" from Profile section
    And the user delete all Profile data record
    And the user enter the achievement data
      | key                  | Value              |
      | Title of Achievement | Best Soccer player |
      | Level of Achievement | District;National  |
      | Grade Level          | Junior;Senior      |
      | Description          | High School Team   |
      
     
    Then the user will loss the above achievement info if navigate to "Tests" page before saving the data
    


  Scenario: The user should be able to enter and save achievement info
    When the user select "Achievements" from Profile section
    And the user delete all Profile data record
    And the user enter the achievement data
      | key                  | Value              |
      | Title of Achievement | Best Soccer player |
      | Level of Achievement | District;National  |
      | Grade Level          | Junior;Senior      |
      | Description          | High School Team   |
    
    And the profile Save button will be enable
    And the user save the information
    Then the user will not loss the above achievement info if visit "Tests" page


  @regression
  Scenario: The user should be able to edit and save an existing achievement info
    When the user select "Achievements" from Profile section
    And the user delete all Profile data record
    And the user enter the achievement data
      | key                  | Value               |
      | Title of Achievement | Soccer player       |
      | Level of Achievement | High School; Local  |
      | Grade Level          | Freshman; Sophomore |
      | Description          | High School         |
    
    And the user save the information 

    When the user edit the achievement info
      | key                  | Value                            |
      | Title of Achievement | Best Soccer player               |
      | Level of Achievement | State or Regional; International |
      | Grade Level          | Junior; Senior                   |
      | Description          | High School Team                 |
    
    And the user save the information
    Then the user will not loss the above modification achievement


  Scenario: The user should be able to disregard the modification on an existing achievement info
    When the user select "Achievements" from Profile section
    And the user delete all Profile data record
    And the user enter the achievement data
      | key                  | Value                            |
      | Title of Achievement | Best Soccer player               |
      | Level of Achievement | State or Regional; International |
      | Grade Level          | Junior; Senior                   |
      | Description          | High School Team                 |
    
    
    And the user save the information

    When the user edit the achievement info
      | key                  | Value               |
      | Title of Achievement | Soccer player       |
      | Level of Achievement | High School; Local  |
      | Grade Level          | Freshman; Sophomore |
      | Description          | High School         |
    
    And the user cancel the modification
    Then the user will disregard the above modification achievement


  @regression
  Scenario: The user should be able to delete or disregard the delete of an existing achievement info
    When the user select "Achievements" from Profile section
    And the user delete all Profile data record
    And the user enter the achievement data
      | key                  | Value               |
      | Title of Achievement | Soccer player       |
      | Level of Achievement | High School; Local  |
      | Grade Level          | Freshman; Sophomore |
      | Description          | High School         |
    
    And the user save the information
    And the user select edit course

    When the user select Delete school
    And the user disregard the deletion 
    Then the achievement record will be displayed 

    When the user select Delete school
    And the user confirm the deletion   
    Then the achievement record will be removed
    And the user should be able to logout  
    
