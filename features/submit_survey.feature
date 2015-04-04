Feature: Submit a survey response

As a student
So that I can give my feedback to professors
I would like to be able to fill out course surveys

Background:
Given the following survey template exists
| question_title    | 
| course name       |
| course instructor |
| year              |

Scenario: Successfully fill out survey
Given I am on the survey template
And I fill in the fields with "CS 169", "Fox", "2015"
And I press submit
Then I should see "Your submission was recorded"
And my submission should be recorded

Scenario: Leave all fields blank
Given I am on the survey template
And I press submit
Then I should see "You need to at least fill out one field!"

Scenario: Submit to the same survey twice
Given I am on the survey template
And I have already submitted to it
When I fill in the fields with "CS169", "Fox", "2015"
And I press submit
Then I should see "You have already responded to this survey"