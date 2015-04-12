Feature: Mark a field as required.

As a professor/TA 
So that I can require students to respond to certain fields
I would like to be able to mark a field as required.

Background:

Given the following survey template exists
| question_title    | type                 | options                          |
| course name       | text_question_fields |                                  |
| course instructor | text_question_fields |                                  |
| year              | text_question_fields |                                  |

Scenario: I mark a field as required
Given I am on the edit survey template
And I mark "course name" as required
Then the survey template should require "course name" to be filled out.

Scenario: I remove a 
Given I am on the edit survey template
And I mark "course name" as required
Then the survey template should not require "course name" to be filled out.