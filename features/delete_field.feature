Feature: Delete a field

As a professor/TA 
So that I can modify my survey templates
I would like to be able to delete a field.

Background:

Given the following survey template exists
| question_title    | 
| course name       |
| course instructor |
| year              |

@javascript
Scenario: I delete a survey field
Given I am on the edit survey template
And I delete the field "course name"
Then the survey template should not have a field "course name"

