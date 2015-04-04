Feature: Authorizing form creation

As an admin, 
So that non-instructors can't create course surveys
I want to be able to add list of authorized instructors who can create and publish forms

Scenario:
Given I am an admin
Then I go to the new survey template page
Then I should be on the new survey template page


Scenario:
Given I am a student
Then I go to the new survey template page
Then I should be on the login page


Scenario:
Given I am an instructor
Then I go to the new survey template page
Then I should be on the new survey template page

Scenario:
Given I am an instructor
Then I go to the new survey template page
Then I should be on the new survey template page