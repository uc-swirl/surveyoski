Feature: Login to account

  As a user of this app
  So that I can take or create and edit surveys
  I want to log in to and out of my account

  @omniauth_test_good
  Scenario: Login successfully as a professor
  And I have logged in as a professor
  And I go to the dashboard page
  Then I should be on the dashboard page

  @omniauth_test_bad
  Scenario: Login unsuccessfully
  And I have not logged in as a professor
  And I go to the dashboard page
  Then I should be on the login page

  @omniauth_test_good
  Scenario: Successfully see survey as a student
  Given I have logged in as a student for a survey template
  And I go to that survey's page
  Then I should be on that survey's page

  @omniauth_test_bad
  Scenario: Redirect student to login page for survey
  Given I have not logged in as a student for a survey template
  And I go to that survey's page
  Then I should be on the login page
