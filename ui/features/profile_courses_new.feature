Feature: The user with an account should be able to save courses data

  Background: The user with an account 
    Given the user is registered and stay login
      | key              | Value           |
      | First name       | Jem             |
      | Last name        | Dell            |
      | Email address    | courses@t.com |
      | Birth Month      | June            |
      | Birth Day        | 22              |
      | Birth Year       | 2001            |
      | Password         | Test123456      |
      | Confirm Password | Test123456      |
      | TOS CheckBox     | True            |
    And the user select Profile from drop down


  @smoke_test
  Scenario: the system should provide below info under courses section
    When the user select "Courses" from Profile section
    And the user delete all Profile data record
    Then the system will display below information under profile section
      """
      Add another course
      You have no courses saved. Click the button above to add one 
      """

    When the user select Add another course
    Then the system will display below information under profile section
      """
        Course Name
        Course Type
          Select
          English
          Foreign Language
          History
          Mathematics
          Science
          Social Studies
          Academic Elective
          Non-academic Elective
          Other
        What is the level of this course?
          Standard
          Academic
          Enriched
          Accelerated
          Gifted
          Advanced
          Honors
          High Honors
          AP Prep
          AP Course
          A/AS level
          Pre-IB
          IB
          College Prep
          College
        What is the highest level of this course offered at the school?
          Standard
          Academic
          Enriched
          Accelerated
          Gifted
          Advanced
          Honors
          High Honors
          AP Prep
          AP Course
          A/AS level
          Pre-IB
          IB
          College Prep
          College
        Grading Method
          Letter (e.g. A-F)
          Numeric (e.g. 1-100)
          N/A
        Final Grade
        Save
        Cancel
      """


  Scenario: the Save button should be disable until the user enter all required fields
    When the user select "Courses" from Profile section
    And the user select Add another course
    Then the Save button would be disable until the user enter all course required fields
      | key            | Value             |
      | Course Name    | Test              |
      | Course Type    | English           |
      | Course Level   | Honors            |
      | Highest Level  | Honors            |
      | Grading Method | Letter (e.g. A-F) |
      | Final Grade    | A                 |
  


  Scenario: The user should be able to disregard the courses change by visiting another page without saving
    When the user select "Courses" from Profile section
    And the user delete all Profile data record
    And the user enter the courses info
      | key            | Value             |
      | Course Name    | Test              |
      | Course Type    | English           |
      | Course Level   | Honors            |
      | Highest Level  | Honors            |
      | Grading Method | Letter (e.g. A-F) |
      | Final Grade    | A                 |
     
    Then the user will loss the above courses info if navigate to "Tests" page before saving the data
    


  Scenario: The user should be able to enter and save courses info
    When the user select "Courses" from Profile section
    And the user delete all Profile data record
    And the user enter the courses info
      | key            | Value                  |
      | Course Name    | Test1                  |
      | Course Type    | Science                |
      | Course Level   | Advanced               |
      | Highest Level  | AP Course              |
      | Grading Method | Numberic (e.g. 1-100)  |
      | Final Grade    | 98                     |
    
    And the user save the information
    Then the user will not loss the above courses info if visit "Tests" page


  @regression
  Scenario: The user should be able to edit and save an existing courses info
    When the user select "Courses" from Profile section
    And the user delete all Profile data record
    And the user enter the courses info
      | key            | Value             |
      | Course Name    | Test2             |
      | Course Type    | English           |
      | Course Level   | Honors          |
      | Highest Level  | Honors            |
      | Grading Method | Letter (e.g. A-F) |
      | Final Grade    | B                 |
    
    And the user save the information

    When the user edit the courses info
      | key            | Value             |
      | Course Name    | Test              |
      | Course Type    | History           |
      | Course Level   | Advanced          |
      | Highest Level  | AP Course         |
      | Grading Method | Letter (e.g. A-F) |
      | Final Grade    | +A                |
    
    And the user save the information
    Then the user will not loss the above modification courses


  Scenario: The user should be able to disregard the modification on an existing courses info
    When the user select "Courses" from Profile section
    And the user delete all Profile data record
    And the user enter the courses info
      | key            | Value             |
      | Course Name    | Test              |
      | Course Type    | History           |
      | Course Level   | Advanced          |
      | Highest Level  | AP Course         |
      | Grading Method | Letter (e.g. A-F) |
      | Final Grade    | +A                |
    
    And the user save the information

    When the user edit the courses info
      | key            | Value             |
      | Course Name    | Test2             |
      | Course Type    | English           |
      | Course Level   | Honors            |
      | Highest Level  | Honors            |
      | Grading Method | Letter (e.g. A-F) |
      | Final Grade    | B                 |
    
    And the user cancel the modification
    Then the user will disregard the above modification courses


  @regression
  Scenario: The user should be able to delete or disregard the delete of an existing courses info
    When the user select "Courses" from Profile section
    And the user delete all Profile data record
    And the user enter the courses info
      | key            | Value             |
      | Course Name    | Test2             |
      | Course Type    | English           |
      | Course Level   | Honors            |
      | Highest Level  | Honors            |
      | Grading Method | Letter (e.g. A-F) |
      | Final Grade    | B                 |
    
    And the user save the information
    And the user select edit course

    When the user select Delete school
    And the user disregard the deletion 
    Then the courses record will be displayed 

    When the user select Delete school
    And the user confirm the deletion   
    Then the courses record will be removed
    And the user should be able to logout  
    

