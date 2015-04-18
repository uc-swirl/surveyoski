Feature:
As an instructor
In order to allow students to fill out the survey
I would like to make a survey live and visible to students

Background:
Given I have logged in as a professor
Given the following survey template exists in course "cs10"
| question_title    | type                 | options                          | required|
| course name       | text_question_fields |                                  | false   |
| course instructor | radio_button_fields  | Fox:Fox,Klein:Klein,DeNero:DeNero| false   |
| year              | drop_down_fields     | 2010:1,2013:1,2014:1,2016:1      | false   |
| hello             | checkbox_fields      | hi:1,hello:1,salutations:1       | false   | 

Scenario: Don't see unpublished surveys that are not my own
Given the following survey template exists in course "cs10"
| question_title    | type                 | options                          | required|
| course name       | text_question_fields |                                  | false   |
| course instructor | radio_button_fields  | Fox:Fox,Klein:Klein,DeNero:DeNero| false   |
| year              | drop_down_fields     | 2010:1,2013:1,2014:1,2016:1      | false   |
| hello             | checkbox_fields      | hi:1,hello:1,salutations:1       | false   | 
And the survey is not published
Given I am not in course "cs10"
When I am on the survey template
Then I should see "This survey is not published."

Scenario: See my unpublished surveys
Given I am in course "cs10"
When I am on the survey template
Then I should not see "This survey is not published"

Scenario: Publish a survey so that all students can see it
Given I am in course "cs10"
And my survey is published
When I have logged in as a student
And I am on the survey template
Then I should see "course name"
And I should see "course instructor"

