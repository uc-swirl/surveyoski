Feature:
As an instructor
So that I can tell which course a survey is in
I want the All Surveys page to have course listed aside with the survey title

Background:
Given I have logged in as a professor
Given the following survey template exists in course "cs169" with name "hallelujah"
| question_title    | type                 | options                          | required|
| course name       | text_question_fields |                                  | true    |
| course instructor | radio_button_fields  | Fox:Fox,Klein:Klein,DeNero:DeNero| true    |
| year              | drop_down_fields     | 2010:1,2013:1,2014:1,2016:1      | true    |
| steak             | checkbox_fields      | rare:1,medium:1,welldone:1       | true    | 

Scenario:
When I go to the survey templates page
Then I should see "hallelujah"
And I should see "cs169"