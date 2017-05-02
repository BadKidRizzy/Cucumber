Feature: The user with an account should be able to save education data

  Background: The user with an account 
    Given the user is registered and stay login
      | key              | Value           |
      | First name       | Jem             |
      | Last name        | Dell            |
      | Email address    | education@t.com |
      | Birth Month      | June            |
      | Birth Day        | 22              |
      | Birth Year       | 2001            |
      | Password         | Test123456      |
      | Confirm Password | Test123456      |
      | TOS CheckBox     | True            |
    And the user select Profile from drop down


  @smoke_test
  Scenario: the system should provide below info under Education section
    When the user select "Education" from Profile section
    And the user delete all Profile data record
    Then the system will display below information under profile section
      """
      High School
      Do you intend to graduate from this school?
      Yes
      No
      Start Date
      Graduation Date
      Unweighted GPA
      / 4.0
      Weighted GPA (optional)
      /
      out of total
      
      Save
      """


  Scenario: the Save button should be disable until the user enter all required fields
    When the user select "Education" from Profile section
    And the user select Add another education
    Then the Save button would be disable until the user enter all education required fields
      | key                | Value   |
      | High School        | CH      |
      | Intend to Graduate | No      |
      | Start Date         | 06/2013 |
      | End Date           | 07/2018 |
      | Unweighted GPA     | 3.35    |
      | Weighted GPA       | 4       |
      | Total Weighted GPA | 5       |

  
  Scenario: The user should be able to disregard the Education change by visiting another page without saving
    When the user select "Education" from Profile section
    And the user delete all Profile data record
    And the user enter the education info
      | key                | Value   |
      | High School        | CH      |
      | Intend to Graduate | No      |
      | Start Date         | 06/2013 |
      | End Date           | 07/2018 |
      | Unweighted GPA     | 3.35    |
      | Weighted GPA       | 4       |
      | Total Weighted GPA | 5       |
      
    Then the user will loss the above education info if navigate to "Courses" page before saving the data
    


  Scenario: The user should be able to enter and save Education info
    When the user select "Education" from Profile section
    And the user delete all Profile data record
    And the user enter the education info
      | key                | Value   |
      | High School        | CH      |
      | Intend to Graduate | Yes     |
      | Start Date         | 06/2013 |
      | Graduation Date    | 07/2017 |
      | Unweighted GPA     | 3.35    |
      | Weighted GPA       | 4       |
      | Total Weighted GPA | 5       |
    
    And the user save the information
    Then the user will not loss the above education info if visit "Courses" page


  @regression
  Scenario: The user should be able to edit and save an existing Education info
    When the user select "Education" from Profile section
    And the user delete all Profile data record
    And the user enter the education info
      | key                | Value   |
      | High School        | CH      |
      | Intend to Graduate | Yes     |
      | Start Date         | 06/2012 |
      | Graduation Date    | 07/2017 |
      | Unweighted GPA     | 3.35    |
      | Weighted GPA       |         |
      | Total Weighted GPA |         |
    
    And the user save the information

    When the user edit the education info
      | key                | Value   |
      | High School        | CH      |
      | Intend to Graduate | No      |
      | Start Date         | 06/2013 |
      | End Date           | 07/2018 |
      | Unweighted GPA     | 3.35    |
      | Weighted GPA       | 4       |
      | Total Weighted GPA | 5       |
    
    And the user save the information
    Then the user will not loss the above modification education


  Scenario: The user should be able to disregard the modification on an existing Education info
    When the user select "Education" from Profile section
    And the user delete all Profile data record
    And the user enter the education info
      | key                | Value   |
      | High School        | CH      |
      | Intend to Graduate | Yes     |
      | Start Date         | 06/2012 |
      | Graduation Date    | 07/2017 |
      | Unweighted GPA     | 3.35    |
      | Weighted GPA       |         |
      | Total Weighted GPA |         |
    
    And the user save the information

    When the user edit the education info
      | key                | Value   |
      | High School        | CH      |
      | Intend to Graduate | No      |
      | Start Date         | 06/2013 |
      | End Date           | 07/2018 |
      | Unweighted GPA     | 3.35    |
      | Weighted GPA       | 4       |
      | Total Weighted GPA | 5       |
    
    And the user cancel the modification
    Then the user will disregard the above modification education


  @regression
  Scenario: The user should be able to delete or disregard the delete of an existing Education info
    When the user select "Education" from Profile section
    And the user delete all Profile data record
    And the user enter the education info
      | key                | Value   |
      | High School        | CH      |
      | Intend to Graduate | Yes     |
      | Start Date         | 06/2012 |
      | Graduation Date    | 07/2017 |
      | Unweighted GPA     | 3.35    |
      | Weighted GPA       |         |
      | Total Weighted GPA |         |
    
    And the user save the information
    And the user select edit education info

    When the user select Delete school
    And the user disregard the deletion 
    Then the education record will be displayed 

    When the user select Delete school
    And the user confirm the deletion   
    Then the education record will be removed
    And the user should be able to logout  
    

