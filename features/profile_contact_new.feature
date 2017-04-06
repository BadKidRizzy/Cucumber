Feature: The user should be able to login and edit the Profile - Contact

Background:
  Given the user is registered and stay login
    | key              | Value           |
    | First name       | Jem             |
    | Last name        | Dell            |
    | Email address    | cotact@t.com    |
    | Birth Month      | June            |
    | Birth Day        | 22              |
    | Birth Year       | 2001            |
    | Password         | Test123456      |
    | Confirm Password | Test123456      |
    | TOS CheckBox     | True            |
  And the user select Profile from drop down


  @smoke_test
  Scenario: the system should provide below info under Contact section
    When the user select "Contact" from Profile section
    Then the system will display below information under profile section
      """
        Email
        Phone Number
        Parent Email
        Country
        Address Line 1
        Address Line 2
        City
        State/Province/Region
        Zip/Postal Code
      """

  
  Scenario: the Save button should be disable until the user enter all required fields
    When the user select "Contact" from Profile section
    Then the profile Save button would be disable
    

  Scenario: The user should be able to disregard the contact info change by visiting another page without saving
    When the user select "Contact" from Profile section
    And the user edit the contact information
      | key                   | Value            |
      | Email address         | profile-15@t.com |
      | Phone Number          | (555) 456-7890   |
      | Parent Email          | parent1@email.com|
      | Country               | United Kingdom   |
      | Address Line 1        | 323 Main St      |
      | Address Line 2        | #330             |
      | City                  | Centreville      |
      | State/Province/Region | MD               |
      | Zip/Postal Code       | 20120            |
  
    Then the user will loss the above contact information if visit "Education" page

      
  @regression
  Scenario: The user should be able to edit and save the contact information
    When the user select "Contact" from Profile section
    And the user enter the contact information
      | key                   | Value            |
      | Email address         | cotact@t.com     |
      | Phone Number          | (703) 456-7899   |
      | Parent Email          | parent@email.com |
      | Country               | United States    |
      | Address Line 1        | 1233 Main St     |
      | Address Line 2        | #3045            |
      | City                  | Fairfox          |
      | State/Province/Region | MD               |
      | Zip/Postal Code       | 20120            |
    And the user save the information
    Then the user will not loss the above contact information if visit "Education" page

    And the user edit the contact information
      | key                   | Value            |
      | Email address         | cotact@t.com     |
      | Phone Number          | (703) 456-7890   |
      | Parent Email          | parent@email.com |
      | Country               | United States    |
      | Address Line 1        | 123 Main St      |
      | Address Line 2        | #304             |
      | City                  | Fairfox          |
      | State/Province/Region | VA               |
      | Zip/Postal Code       | 20121            |
    And the user save the information
    Then the user will not loss the above contact information if visit "Education" page
    

  Scenario: The user should be able to update and save the email address
    When the user select "Contact" from Profile section
    And the user edit the contact information
      | key                   | Value            |
      | Email address         | profile11@t.com  |
      | Phone Number          | (703) 456-7890   |
      | Parent Email          | parent@email.com |
      | Country               | United States    |
      | Address Line 1        | 123 Main St      |
      | Address Line 2        | #304             |
      | City                  | Fairfox          |
      | State/Province/Region | VA               |
      | Zip/Postal Code       | 20121            |
    And the user save the information
    And the user should be able to logout
    
    When the user try to login using the update email
    And the user select "Contact" from Profile section
    And the user edit the contact information
      | key                   | Value            |
      | Email address         | profile@t.com    |
      | Phone Number          | (703) 456-7890   |
      | Parent Email          | parent@email.com |
      | Country               | United States    |
      | Address Line 1        | 123 Main St      |
      | Address Line 2        | #304             |
      | City                  | Fairfox          |
      | State/Province/Region | VA               |
      | Zip/Postal Code       | 20121            |
    And the user save the information
    And the user should be able to logout

      
  

    