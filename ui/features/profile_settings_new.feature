@profile
Feature: The user should be able to login and edit the Profile - Settings

Background:
  Given the user is registered and stay login
    | key              | Value           |
    | First name       | Jem             |
    | Last name        | Dell            |
    | Email address    | setting@t.com   |
    | Birth Month      | June            |
    | Birth Day        | 22              |
    | Birth Year       | 2001            |
    | Password         | Test123456      |
    | Confirm Password | Test123456      |
    | TOS CheckBox     | True            |
  And the user select Profile from drop down


  @smoke_test
  Scenario: the system should provide below info under Settings section
    When the user select "Settings" from Profile section
    Then the system will display below information under profile section
      """
      Profile
      About me
      Contact
      Payment
      Settings
      Education
      Courses
      Tests
      Activities
      Achievements
      Notifications
      Email Notifications
      Web Notifications
      Daily
      Weekly
      Monthly
      Text Notifications
      Marketing Emails
      Daily
      Weekly
      Monthly

      Save


      Password Reset
      Forgot your password?
      current password
      new password
      confirm new password
      """


   Scenario: the Save button should be disable until the user enter all required fields
    When the user select "Settings" from Profile section
    Then the profile Save button would be disable


  Scenario: The user should be able to disregard the Notifications Setting change by visiting another page without saving
    When the user select "Settings" from Profile section
    And the user enter the notifications setting
      | key                         | Value   |
      | Email Notifications         | On      |
      | Web Notifications           | On      |
      | Web Notifications Frequency | Weekly  |
      | Text Notifications          | On      |
      | Marketing Emails            | On      |
      | Marketing Emails Frequency  | Monthly |

    Then the user will loss the above notifications setting if visit "Education" page


  Scenario: The user should be able to set Web Notifications Frequency
    Given the user select "Settings" from Profile section
    When the user set Web Notifications Frequency as "Daily"
    Then the "Daily" Web Notifications Frequency is selected

    When the user set Web Notifications Frequency as "Weekly"
    Then the "Weekly" Web Notifications Frequency is selected

    When the user set Web Notifications Frequency as "Monthly"
    Then the "Monthly" Web Notifications Frequency is selected

    When the user turn off the Web Notifications
    Then the Web Notifications Frequency is disabled


  Scenario: The user should be able to set Marketing Emails Frequency
    Given the user select "Settings" from Profile section
    When the user set Marketing Emails Frequency as "Daily"
    Then the "Daily" Marketing Emails Frequency is selected

    When the user set Marketing Emails Frequency as "Weekly"
    Then the "Weekly" Marketing Emails Frequency is selected

    When the user set Marketing Emails Frequency as "Monthly"
    Then the "Monthly" Marketing Emails Frequency is selected

    When the user turn off the Marketing Emails
    Then the Marketing Emails Frequency is disabled


  Scenario: The user should be able to edit and save the Notifications Setting
    When the user select "Settings" from Profile section
    And the user enter the notifications setting
      | key                         | Value   |
      | Email Notifications         | On      |
      | Web Notifications           | On      |
      | Web Notifications Frequency | Weekly  |
      | Text Notifications          | On      |
      | Marketing Emails            | On      |
      | Marketing Emails Frequency  | Monthly |

    And the user save the information
    Then the user will not loss the above notifications setting if visit "Education" page

    And the user edit the notifications setting
      | key                         | Value   |
      | Email Notifications         | Off     |
      | Web Notifications           | Off     |
      | Web Notifications Frequency | Weekly  |
      | Text Notifications          | Off     |
      | Marketing Emails            | Off     |
      | Marketing Emails Frequency  | Monthly |

    And the user save the information
    Then the user will not loss the above notifications setting if visit "Education" page


  @regression
  Scenario: The user should be able to reset the password
    Given the user select "Settings" from Profile section
    When the user enter the current password "Test123456"
    And the user enter the new and re-type new password "Test654321"
    And the user should be able to logout
    Then the user should be able to login using "profile@t.com " and new password "Test654321"

    Given the user select "Settings" from Profile section
    When the user enter the current password "Test654321"
    And the user enter the new and re-type new password "Test123456"
    And the user should be able to logout
