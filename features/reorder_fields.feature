Feature: Reorder fields


As a professor/TA 
So that I can change the order in which my survey fields are show to students
I would like to be able to drag and drop my existing survey's fields to reorder them

Background:

Given the following survey template exists
| question_title    | 
| course name       |
| course instructor |
| year              |

@javascript
Scenario: I drag a field to the top
Given I am on the edit survey template
And I drag "year" to be above "course name"
And I save the survey
Then "year" should come before "course name" on the edit survey page

@javascript
Scenario: I drag a field to the bottom
Given I am on the edit survey template
And I drag "course name" to be below "year"
And I save the survey
Then "year" should come before "course name" on the edit survey page