Feature: The user should be able to login and edit the Profile  
  
  @smoke_test
  Scenario: The system should display the user registration information in profile section
    Given the user is registered with below information
      | key              | Value           |
      | First name       | Jem             |
      | Last name        | Dell            |
      | Email address    | profile@t.com   |
      | Birth Month      | June            |
      | Birth Day        | 22              |
      | Birth Year       | 2001            |
      | Password         | Test123456      |
      | Confirm Password | Test123456      |
      | TOS CheckBox     | True            |
    And the user select Profile from drop down

    When the user select "About me" from Profile section
    Then the system display the user name
    And the system display the user date of birth
    And the profile Save button would be disable
    
    When the user select "Contact" from Profile section
    Then the system display the user email address
    And the profile Save button would be disable
    
