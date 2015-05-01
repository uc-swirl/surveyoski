Feature: View Submissions for a Survey

  As a professor
  So that I can become a better teacher
  I want to view my the submissions to my survey

  Background:
  Given the following survey template exists in course "hello" with name "hi there"
  | question_title    | type                 | options                          | required|
  | course name       | text_question_fields |                                  | false    |
  | course instructor | radio_button_fields  | Fox:Fox,Klein:Klein,DeNero:DeNero| false    |
  | year              | drop_down_fields     | 2010:1,2013:1,2014:1,2016:1      | false    |
  | steak             | checkbox_fields      | rare:1,medium:1,welldone:1       | false    |
  And the survey is published
  And there are 11 submissions filled out with "CS 169", "Fox", "2010", "rare:medium"

  Scenario: See results table and download CSV link
  Given I am on the survey responses page
  And I should see a download link to a csv of the responses