Feature: clone a survey

  As a professor or admin
  So I can reuse or extend previous surveys
  I want to clone surveys

  Background:
  Given the following survey template exists
  | question_title    | 
  | course name       |
  | course instructor |
  | year              |

  @omniauth_test_good
  Scenario: Successfully clone a survey as a professor
  Given I have logged in as a professor
  And I go to the survey templates page
  And I clone the survey
  Then I should see another survey
  And this survey should have the same fields as the first survey
