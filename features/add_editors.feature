Feature: As an Instructor 
So that I can share surveys for my course
I want to be able to create a course

Background:
Given I have logged in as a professor
And I go to the new course page
And I make a new course called "CS169"

Scenario: add user as an editor to a course
Given "Marco" is a user with email "marcojoemontagna@berkeley.edu"
When I go to the courses page
And I add him to the first course
Then I should be on the page for that course
And I should see "Successfully added Marco as an editor" 

Scenario: add nonexistent user as an editor to a course
Given "Marco" is not a user with email "marcojoemontagna@berkeley.edu"
When I go to the courses page
And I add him to the first course
Then I should be on the page for that course
And I should see "That user doesn't exist" 

Scenario: users can only see their own course surveys
When I go to the courses page
Then I should see "CS169"
When I have logged in as a professor
And I go to the new course page
And I make a new course called "Cog Sci 1"
And I go to the courses page
Then I should not see "CS169"
And I should see "Cog Sci 1"