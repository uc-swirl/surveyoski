Feature: 
As a professor
So that I can have privacy and convenience
I want to only see my own surveys (and public ones) and not other people's.

Background: 
Given the following users exist:
| name     | email                      | status     |
| Jekyll   | andhyde@berkeley.edu       | professor  |
And course "CogSci1" has survey "This isn't"
And course "CogSci127" has survey "This is mine"
And "Jekyll" is in course "CogSci1"

Given I have logged in as a professor
And I am in course "CogSci127"
And I go to the survey templates page

Scenario: see surveys for my courses

Then I should see "This is mine"

Scenario: don't see surveys not for my courses

And I should not see "This isn't"