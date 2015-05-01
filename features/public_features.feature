Feature: As a survey creator
In order to share my surveys with other users
I would like to be able to make my survey public.

Background: 
Given I have logged in as a professor
Given the following survey template exists in course "cs169" with name "meep"
| question_title    | type                 | options                          | required|
| course name       | text_question_fields |                                  | true    |
| course instructor | radio_button_fields  | Fox:Fox,Klein:Klein,DeNero:DeNero| true    |
| year              | drop_down_fields     | 2010:1,2013:1,2014:1,2016:1      | true    |
| steak             | checkbox_fields      | rare:1,medium:1,welldone:1       | true    | 

@javascript
Scenario: make a survey public
Given I go to the edit survey page
When I make the survey public
Then I have logged in as a professor
And I go to the survey templates page
Then I should see "cs169"
And I should see "meep"
