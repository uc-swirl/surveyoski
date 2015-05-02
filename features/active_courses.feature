Feature: As an instructor
So that I can find current courses easily
I want to be able to activate and deactivate courses

Background:
Given I have logged in as a professor
Given "course1" is an active course
Given "course2" is an inactive course

Scenario: Only see active courses
Given I am on the new survey template page
Then I should see "course1"
Then I should not see "course2"

Scenario: Survey edit page for survey in inactive course shows inactive course
Given my inactive course has a template
When I go to the edit survey page
Then I should see "course2"