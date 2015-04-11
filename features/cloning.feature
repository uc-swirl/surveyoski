Feature: clone a survey

  As a professor or admin
  So I can reuse or extend previous surveys
  I want to clone surveys

  Background:
  Given the following survey template exists
  | question_title    | type                 | options                          |
  | course name       | text_question_fields |                                  |
  | course instructor | radio_button_fields  | Fox:Fox,Klein:Klein,DeNero:DeNero|
  | year              | drop_down_fields     | 2010:1,2013:1,2014:1,2016:1      |

  @omniauth_test_good
  Scenario: Successfully clone a survey as a professor
  Given I have logged in as a professor
  And I go to the survey templates page
  And I clone the survey
  Then I should see another survey
  And this survey should have the same fields as the first survey
