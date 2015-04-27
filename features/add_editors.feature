Feature: As an Instructor 
So that my TAs can edit my surveys
I want to be able to make a course and add TAs to it

Background:
Given I have logged in as a professor
And I go to the new course page
Then I should see "New Course"
And I make a new course called "24601"

Scenario: add user as an editor to a course
Given "Marco" is a user with email "marcojoemontagna@berkeley.edu"
When I go to the courses page
And I add him to the first course
Then I should be on the courses page
And I should see "Your course 24601 was successfully updated" 

Scenario: add nonexistent user as an editor to a course
Given "Marco" is not a user with email "marcojoemontagna@berkeley.edu"
When I go to the courses page
And I add him to the first course
Then I should be on the courses page
And I should see "There was an error in updating your course." 

Scenario: users can only see their own courses
When I go to the courses page
Then I should see "24601"
When I have not logged in as a professor
Given I have logged in as a professor
And I go to the new course page
Then I should see "New Course"
And I make a new course called "CS188"
And I go to the courses page
Then I should not see "24601"
And I should see "CS188"