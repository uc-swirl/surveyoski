Feature: Submit a survey response

As a student
So that I can give my feedback to professors
I would like to be able to fill out course surveys

Background:
Given the following survey template exists
| question_title    | type                 | options                          |
| course name       | text_question_fields |                                  |
| course instructor | radio_button_fields  | Fox:Fox,Klein:Klein,DeNero:DeNero|
| year              | drop_down_fields     | 2010:1,2013:1,2014:1,2016:1      |
| steak             | checkbox_fields      | rare:1,medium:1,welldone:1       |

Scenario: Successfully fill out survey
Given I am on the survey template
And I fill in the fields with "CS 169", "Fox", "2010", "rare:medium"
And I press submit
Then I should see "Your submission was recorded"
And my submission should be recorded

Scenario: Submit to the same survey twice
Given I am on the survey template
And I have already submitted to it
And I fill in the fields with "CS 169", "Fox", "2010", "medium:welldone"
And I press submit
Then I should see "You have already responded to this survey"