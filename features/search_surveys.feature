Feature:
As a survey creator
In order to reuse and/or clone surveys that are already created
I would like to be able to search for them by course, department, and/or year


Background:
Given I have logged in as a professor
Given a bunch of public and private surveys exist

@omniauth_test_good
Scenario: Only see my surveys
When I filter by checking "my_surveys"
Then my surveys should be present
And public surveys should not be present 

@omniauth_test_good
Scenario: Only see public surveys
When I filter by checking "public_surveys"
Then "my" surveys should not be present
And "public" surveys should be present 

@omniauth_test_good
Scenario: Only see surveys from a certain year
When I filter by dropdown select "Spring 2015"
Then "Spring 2015" surveys should be present
And "Fall 2013" surveys should not be present