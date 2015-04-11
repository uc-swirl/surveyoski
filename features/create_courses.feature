Feature: 
As an Instructor 
So that I can share surveys for my course
I want to be able to create a course

Background:
Given I have logged in as a professor
And I go to the new course page
And I make a new course called "CS169"

Scenario: go to courses page
When I go to the courses page
Then I should see "Add a course"

Scenario: create a course
When I go to the new course page
When I make a new course called "CS188"
Then I should be on the courses page
And I should see "Your new course"
And I should see "was successfully created"

Scenario: delete a course
When I go to the courses page
And I delete the first course
Then I should be on the courses page
And I should see "Your course was deleted"