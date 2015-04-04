


Feature: Survey creation
As a course instuctor or TA,
So that I can get feedback from students
I would like to make new course surveys


Scenario: Form Creation
Given I am on the new survey template page
Then I should be on the new/edit survey page


Scenario:
Given I am an instructor
And I make a new survey
Then I should be on the new/edit survey page
