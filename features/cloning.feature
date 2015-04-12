Feature: clone a survey

  As a professor or admin
  So I can reuse or extend previous surveys
  I want to clone surveys

  Background:
  Given the following survey template exists
  | question_title    | type                 | options                          | required|
  | course name       | text_question_fields |                                  | true    |
  | course instructor | radio_button_fields  | Fox:Fox,Klein:Klein,DeNero:DeNero| true    |
  | year              | drop_down_fields     | 2010:1,2013:1,2014:1,2016:1      | true    |
  | steak             | checkbox_fields      | rare:1,medium:1,welldone:1       | true    |

  @omniauth_test_good
  Scenario: Successfully clone a survey as a professor
  Given I have logged in as a professor
  And I go to the survey templates page
  And I clone the survey
  Then I should see another survey
  And this survey should have the same fields as the first survey
