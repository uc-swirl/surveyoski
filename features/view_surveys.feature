Feature:
As an instructor
So that I won't be overwhelmed by all the surveys on the page
I want to see reasonable subsets of the surveys at a time


Background:
Given I have logged in as a professor
Given "20" public surveys and "20" private surveys exist

Scenario: Only see part of the surveys on the page
Given I go to the survey templates page
Then I should see survey 10
And I should not see survey 11