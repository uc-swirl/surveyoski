Feature:
As a survey creator
In order to reuse and/or clone surveys that are already created
I would like to be able to search for them by course, department, and/or year

Background:
Given I have logged in as a professor
Given a bunch of public and private surveys exist


@omniauth_test_good
Scenario: Only see surveys from a certain semester
When I filter by semester "Spring"
And "Fall" surveys should not be present


@omniauth_test_good
Scenario: Only see surveys from a certain year
When I filter by year "2015"
And "2013" surveys should not be present
