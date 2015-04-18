Feature: Always display survey creator on the survey

  As a student
  So that I can take the correct survey
  I want to be able to tell who (which instructor) created the survey.

  Background:
    Given the following survey template exists in course "cs169"
      | question_title    | type                 | options                          | required|
      | course name       | text_question_fields |                                  | true    |
      | course instructor | radio_button_fields  | Fox:Fox,Klein:Klein,DeNero:DeNero| true    |
      | year              | drop_down_fields     | 2010:1,2013:1,2014:1,2016:1      | true    |
      | steak             | checkbox_fields      | rare:1,medium:1,welldone:1       | true    |

  Scenario: Successfully fill out survey
    Given I am on the survey template
    Then I should see "Created by john"