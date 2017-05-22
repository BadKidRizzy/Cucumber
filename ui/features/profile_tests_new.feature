@profile
Feature: The user with an account should be able to save tests data

  Background: The user with an account 
    Given the user is registered and stay login
      | key              | Value           |
      | First name       | Jem             |
      | Last name        | Dell            |
      | Email address    | tests@t.com     |
      | Birth Month      | June            |
      | Birth Day        | 22              |
      | Birth Year       | 2001            |
      | Password         | Test123456      |
      | Confirm Password | Test123456      |
      | TOS CheckBox     | True            |
    And the user select Profile from drop down


  @smoke_test
  Scenario: the system should provide below info under tests section
    When the user select "Tests" from Profile section
    And the user delete all Profile data record
    Then the system will display below information under profile section
      """
        Test
          select
          SAT
          SAT Subject
          ACT
          AP
          IB
        Subject
          select
        Test Date
        Score
        Save
      """
    

  @smoke_test
  Scenario: the user should be able to select subject for any Test
    When the user select "Tests" from Profile section
    And the user select "SAT" test
    Then the user will have below options to choose for subject  
      | subject options                     |
      | select                              |
      | Evidence-Based Reading and Writing  |
      | Math                                |

    When the user select "SAT Subject" test
    Then the user will have below options to choose for subject 
      | subject options |
      | select          |
      | select          |
      | Literature      |
      | U.S. History    |
      | World History   |
      | Mathematics     |
      | Mathematics     |
      | Biology         |
      | Chemistry       |
      | Physics         |
      | Chinese         |
      | French          |
      | French          |
      | German          |
      | German          |
      | Modern Hebrew   |
      | Italian         |
      | Japanese        |
      | Korean          |
      | Latin           |
      | Spanish         |
      | Spanish         |
      

    When the user select "ACT" test
    Then the user will have below options to choose for subject 
      | subject options   |
      | select            |
      | composite         |   
      
    When the user select "AP" test
    Then the user will have below options to choose for subject   
      | subject options                        |
      | select                                 |
      | Art History                            |
      | Biology                                |
      | Calculus AB                            |
      | Calculus BC                            |
      | Chemistry                              |
      | Chinese Language and Culture           |
      | Computer Science A                     |
      | Computer Science Principles            |
      | English Language and Composition       |
      | English Literature and Composition     |
      | Environmental Science                  |
      | European History                       |
      | French Language                        |
      | German Language                        |
      | Government and Politics: Comparative   |
      | Government and Politics: United States |
      | Human Geography                        |
      | Italian Language and Culture           |
      | Japanese Language and Culture          |
      | Latin                                  |
      | Macroeconomics                         |
      | Microeconomics                         |
      | Music Theory                           |
      | Physics 1                              |
      | Physics 2                              |
      | Physics C: Electricity and Magnetism   |
      | Physics C: Mechanics                   |
      | Psychology                             |
      | Capstone Research                      |
      | Capstone Seminar                       |
      | Statistics                             |
      | Spanish Language                       |
      | Spanish Literature                     |
      | Studio Art: 2-D Design                 |
      | Studio Art: 3-D Design                 |
      | Studio Art: Drawing                    |
      | United States History                  |
      | World History                          |

    When the user select "IB" test
    Then the user will have below options to choose for IB subject 
      """
      Art History\nAstronomy\nBiology\nBusiness and Management\nChemistry\nChinese Studies\nClassical Greek\nClassical Greek and Roman Studies\nComputer Science\nDance\nDesign Tech.\nEconomics\nElectronics\nEnglish A\nEnglish AB\nEnglish B\nEnvironmental Systems and Societies\nFilm\nFurther Mathematics\nGeography\nHis&Con B/Stu\nHistory\nHistory of Africa\nHistory of Asia and Oceana\nHistory of Europe and the Middle East\nHistory of the Americas\nHuman Rights\nInformation Technology in a Global Society\nLanguage\nLanguage & Literature\nLatin\nLiterature and Performance\nMarine Science\nMathematics\nMathmatical Studies\nMusic\nMusic Creating\nMusic Group Performance\nMusic Solo Performance\nPeace and Conflict Studies\nPhilosophy\nPhysics\nPolitical Th.\nPolitics\nPsychology\nRef Project\nScience, Technology and Society\nSoc.Cul.Anth.\nSports Exercise and Health Science\nTheatre\nTheory of Knowledge\nVisual Arts\nWorld Arts and Cultures\nWorld Politics\nWorld Religions\nWorld Studies
      """

     
      

  Scenario: the Save button should be disable until the user enter all required fields
    When the user select "Tests" from Profile section
    And the user select Add another test
    Then the Save button would be disable until the user enter all test required fields
      | key             | Value                               |
      | Test            | SAT                                 |
      | Subject         | Evidence-Based Reading and Writing  |
      | Test date       | 06/2013                             |
      | Score           | 200                                 |
  


  
  Scenario: The user should be able to disregard the tests change by visiting another page without saving
    When the user select "Tests" from Profile section
    And the user delete all Profile data record
    And the user enter the test data
      | key             | Value                               |
      | Test            | SAT                                 |
      | Subject         | Evidence-Based Reading and Writing  |
      | Test date       | 06/2013                             |
      | Score           | 200                                 |
     
    Then the user will loss the above test info if navigate to "Education" page before saving the data
    

  
  Scenario: The user should be able to enter and save test info
    When the user select "Tests" from Profile section
    And the user delete all Profile data record
    And the user enter the test data
      | key             | Value                               |
      | Test            | SAT                                 |
      | Subject         | Evidence-Based Reading and Writing  |
      | Test date       | 06/2013                             |
      | Score           | 200                                 |
    
    And the user save the information
    Then the user will not loss the above test info if visit "Education" page


  @regression
  Scenario: The user should be able to edit and save an existing test info
    When the user select "Tests" from Profile section
    And the user delete all Profile data record
    And the user enter the test data
      | key             | Value                               |
      | Test            | SAT                                 |
      | Subject         | Evidence-Based Reading and Writing  |
      | Test date       | 06/2013                             |
      | Score           | 200                                 |
    
    And the user save the information

    When the user edit the test info
      | key       | Value     |
      | Test      | ACT       |
      | Subject   | composite |
      | Test date | 06/2014   |
      | Score     | 35        |
    
    And the user save the information
    Then the user will not loss the above modification test


  
  Scenario: The user should be able to disregard the modification on an existing test info
    When the user select "Tests" from Profile section
    And the user delete all Profile data record
    And the user enter the test data
      | key             | Value                               |
      | Test            | SAT                                 |
      | Subject         | Evidence-Based Reading and Writing  |
      | Test date       | 06/2013                             |
      | Score           | 200                                 |
    
    
    And the user save the information

    When the user edit the test info
      | key       | Value   |
      | Test      | ACT     |
      | Subject   | Reading |
      | Test date | 06/2014 |
      | Score     | 35      |
    
    And the user cancel the modification
    Then the user will disregard the above modification test


  @regression
  Scenario: The user should be able to delete or disregard the delete of an existing test info
    When the user select "Tests" from Profile section
    And the user delete all Profile data record
    And the user enter the test data
      | key       | Value   |
      | Test      | AP      |
      | Subject   | Biology |
      | Test date | 06/2014 |
      | Score     | 3.5     |
    
    And the user save the information
    And the user select edit course

    When the user select Delete school
    And the user disregard the deletion 
    Then the test record will be displayed 

    When the user select Delete school
    And the user confirm the deletion   
    Then the test record will be removed
    And the user should be able to logout  
    
