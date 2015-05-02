Feature: View Graphical Representations of survey submissions

As a professor
  In order to visualize responses
  I would like to see graphical summaries of the data

Background:
Given the following survey template exists in course "hello" with name "hi there"
| question_title    | type                 | options                          | required|
| course name       | text_question_fields |                                  | false    |
| course instructor | radio_button_fields  | Fox:Fox,Klein:Klein,DeNero:DeNero| false    |
| year              | drop_down_fields     | 2010:1,2013:1,2014:1,2016:1      | false    |
| steak             | checkbox_fields      | rare:1,medium:1,welldone:1       | false    |
And the survey is published
And there are 11 submissions filled out with "CS 169", "Fox", "2010", "rare:medium"
And the survey is closed

@javascript
Scenario: See charts for results summary
And I am on the survey responses page
Then I should see some charts
