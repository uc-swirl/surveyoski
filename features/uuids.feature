Feature:
As a survey creator
So that students can’t guess at survey urls
I would like to generate a universally unique identifier for my survey

Background:

Given I have logged in as a professor
Given the following survey template exists in course "cs169" with name "meep"
| question_title    | type                 | options                          | required|
| course name       | text_question_fields |                                  | true    |
| course instructor | radio_button_fields  | Fox:Fox,Klein:Klein,DeNero:DeNero| true    |
| year              | drop_down_fields     | 2010:1,2013:1,2014:1,2016:1      | true    |
| steak             | checkbox_fields      | rare:1,medium:1,welldone:1       | true    | 

Scenario: See uuid instead of id in the url
Given I am on the survey template
Then the url should have the uuid instead of the id