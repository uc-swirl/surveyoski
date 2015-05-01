Feature: Check the disclaimer on the survey page

  As a student
  So that I can express my opinions freely
  I want to for sure know that even though I've signed in with my berkeley.edu that my response will remain anonymous

  Background:
    Given the following survey template exists in course "cs169" with name "hello world"
      | question_title    | type                 | options                          | required|
      | course name       | text_question_fields |                                  | true    |
      | course instructor | radio_button_fields  | Fox:Fox,Klein:Klein,DeNero:DeNero| true    |
      | year              | drop_down_fields     | 2010:1,2013:1,2014:1,2016:1      | true    |
      | steak             | checkbox_fields      | rare:1,medium:1,welldone:1       | true    |

  Scenario: Successfully fill out survey
    Given I am on the survey template
    Then I should see "NOTICE: Your CalNet ID is used for authentication and authorization to the system. Your survey responses are stored anonymously. Identification information is used expressly for the purpose of verifying that you are a registered UCB student."