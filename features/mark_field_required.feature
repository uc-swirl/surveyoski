Feature: Mark a field as required.

As a professor/TA 
So that I can require students to respond to certain fields
I would like to be able to mark a field as required.

Background:

Given the following survey template exists
| question_title    | 
| course name       |
| course instructor |
| year              |

Scenario: I mark a field as required
Given I am on the edit survey template
And I mark "course name" as required
Then the survey template should require "course name" to be filled out.

Scenario: I remove a 
Given I am on the edit survey template
And I mark "course name" as required
Then the survey template should not require "course name" to be filled out.