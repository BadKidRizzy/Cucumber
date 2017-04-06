Feature: The user should be able to login and edit the Profile - About me

Background:
  Given the user is registered and stay login
    | key              | Value           |
    | First name       | Jem             |
    | Last name        | Dell            |
    | Email address    | aboutMe@t.com   |
    | Birth Month      | June            |
    | Birth Day        | 22              |
    | Birth Year       | 2001            |
    | Password         | Test123456      |
    | Confirm Password | Test123456      |
    | TOS CheckBox     | True            |
  And the user select Profile from drop down

  @smoke_test
  Scenario: the system should provide below info under About me section
    When the user select "About me" from Profile section
    Then the system will display below information under profile section   
      """
        Profile
        About me
        Contact
        Settings
        Education
        Courses
        Tests
        Activities
        Achievements

        First name
        Last name
        What grade are you in?
          freshman
          9th grade
          sophomore
          10th grade
          junior
          11th grade
          senior
          12th grade
        Gender
          Female
          Male
        Date of Birth
        Citizenship
        Ethnicity
          select
          Hispanic or Latino
          Not Hispanic nor Latino
          Wish to not report
        Race
          select
          American Indian / Alaska Native
          Asian
          Black or African American
          Native Hawaiian / Other Pacific Islander
          White
          Wish to not report
      """
 
  
  Scenario: the Save button should be disable until the user enter all required fields
    When the user select "About me" from Profile section
    Then the profile Save button would be disable



  Scenario: The user should be able to disregard the About me change by visiting another page without saving
    When the user select "About me" from Profile section
    And the user enter the about me information
      | key              | Value                    |
      | First name       | Kev                      |
      | Last name        | Delle                    |
      | Grade            | junior                   |
      | Gender           | Female                   |
      | Birth Month      | July                     |
      | Birth Day        | 24                       |
      | Birth Year       | 2003                     |
      | Citizenship      | Austria                  |
      | Ethnicity        | Hispanic or Latino       |
      | Race             | Asian                    |
  
    Then the user will loss the above about me information if visit "Contact" page

      
  @regression
  Scenario: The user should be able to edit and save the About me information
    When the user select "About me" from Profile section
    And the user enter the about me information
      | key              | Value                    |
      | First name       | Kev                      |
      | Last name        | Delle                    |
      | Grade            | sophomore                |
      | Gender           | Male                     |
      | Birth Month      | June                     |
      | Birth Day        | 24                       |
      | Birth Year       | 2003                     |
      | Citizenship      | United States            |
      | Ethnicity        | Not Hispanic nor Latino  |
      | Race             | White                    |
    And the user save the information
    Then the user will not loss the above about me information if visit "Contact" page

    And the user edit the about me information
      | key              | Value                    |
      | First name       | Jem                      |
      | Last name        | Dell                     |
      | Grade            | sophomore                |
      | Gender           | Male                     |
      | Birth Month      | June                     |
      | Birth Day        | 22                       |
      | Birth Year       | 2001                     |
      | Citizenship      | United States            |
      | Ethnicity        | Not Hispanic nor Latino  |
      | Race             | White                    |
    And the user save the information
    Then the user will not loss the above about me information if visit "Contact" page
    And the user should be able to logout
      
    


  

  

    