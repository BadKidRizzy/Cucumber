Feature: The system will provide the user Notes option with schools, majors and occupations


  Background: 
    Given the user A register and stay login  
        | key              | Value           |
        | First name       | Jem             |
        | Last name        | Dell            |
        | Email address    | note@gmail.com  |
        | Birth Month      | June            |
        | Birth Day        | 22              |
        | Birth Year       | 2001            |
        | Password         | Test123456      |
        | Confirm Password | Test123456      |
        | TOS CheckBox     | True            |

  
  @smoke_test
  Scenario: the system should provide notes option for user with an account
    Given the user from Home Page navigate to School search Page
    And the user select a university
    
    When the user select Notes from detail page
    And the user delete all existing note
    
    Then the system should be displayed below info. under Notes section
      | notes section |
      | Add a note    |
      | New note      |
      | Delete        |
      | Save          |

    And the save note button would be disabled


  @smoke_test
  Scenario: the system should inform the user with required fields
    Given the user from Home Page navigate to School search Page
    And the user select a university
    
    When the user select Notes from detail page
    Then the system should display optional for not required field


  @regression
  Scenario: the user with an account should be able to create and save notes for Schools
    Given the user from Home Page navigate to School search Page
    And the user select a university
    
    When the user select Notes from detail page
    And the user delete all existing note
    
    When the user add and save note(s)
      | note title          | note body     | 
      | School title        | School body   |
      
    And the user visit Academic page and return back
    Then the system should displayed "School title" and "School body" under notes
    


  Scenario: the user with an account should be able to create and save notes for Majors 
    Given the user from Home Page navigate to Majors search Page
    And the user select a university
    
    When the user select Notes from detail page
    And the user delete all existing note
    
    When the user add and save note(s)
      | note title          | note body     | 
      | Majors title        | Majors body   |

    And the user visit Description page and return back
    Then the system should displayed "Majors title" and "Majors body" under notes


  Scenario: the user with an account should be able to create and save notes for Occupations 
    Given the user from Home Page navigate to Occupations search Page
    And the user select a university
    
    When the user select Notes from detail page
    And the user delete all existing note
    
    When the user add and save note(s)
      | note title          | note body         | 
      | Occupations title   | Occupations body  |

    And the user visit Description page and return back
    Then the system should displayed "Occupations title" and "Occupations body" under notes

  
  Scenario: the user with an account should be able to create more than one note for Schools
    Given the user from Home Page navigate to School search Page
    And the user select a university
    
    When the user select Notes from detail page
    And the user delete all existing note
    
    When the user add and save note(s)
      | note title  | note body   | 
      | title 1     | body 1      |
      | title 2     | body 2      |
      | title 3     | body 3      |
      

    Then the system should be displayed below title
      | note title  |  
      | title 1     | 
      | title 2     | 
      | title 3     | 


  Scenario: the user with an account should be able to create more than one note for Majors 
    Given the user from Home Page navigate to Majors search Page
    And the user select a university
    
    When the user select Notes from detail page
    And the user delete all existing note
    
    When the user add and save note(s)
      | note title  | note body   | 
      | title 1     | body 1      |
      | title 2     | body 2      |
      | title 3     | body 3      |
      

    Then the system should be displayed below title
      | note title  |  
      | title 1     | 
      | title 2     | 
      | title 3     | 


  Scenario: the user with an account should be able to create more than one note for Occupations 
    Given the user from Home Page navigate to Occupations search Page
    And the user select a university
    
    When the user select Notes from detail page
    And the user delete all existing note
    
    When the user add and save note(s)
      | note title  | note body   | 
      | title 1     | body 1      |
      | title 2     | body 2      |
      | title 3     | body 3      |
      

    Then the system should be displayed below title
      | note title  |  
      | title 1     | 
      | title 2     | 
      | title 3     | 



  @regression
  Scenario: the delete button should be disabled after the user with an account delete all notes 
    Given the user from Home Page navigate to School search Page
    And the user select a university
    
    When the user select Notes from detail page
    And the user delete all existing note
    
    When the user add and save note(s)
      | note title            | note body         | 
      | School title test     | School body test  |
      
    And the user visit Academic page and return back
    Then the system should displayed "School title test" and "School body test" under notes

    When the user delete all existing note
    Then the delete note button would be disabled 


  @regression
  Scenario: the user should loss the note data when navigate to another page without saving 
    Given the user from Home Page navigate to School search Page
    And the user select a university
    
    When the user select Notes from detail page
    And the user delete all existing note
    
    When the user add but did not save note
      | note title            | note body         | 
      | School title test     | School body test  |
      
    And the user visit Academic page and return back
    Then the user should loss the note data





