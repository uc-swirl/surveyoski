Feature: Login to account

  As a user of this app
  So that I can take or create and edit surveys
  I want to log into my account

  Scenario: Login successfully as a professor
  And I have logged in as a professor
  And I go to the dashboard page
  Then I should be on the dashboard page

  Scenario: Login successfully as an admin
  And I have logged in as a professor
  And I go to the dashboard page
  Then I should be on the dashboard page

  Scenario: Login successfully as a TA
  And I have logged in as a professor
  And I go to the dashboard page
  Then I should be on the dashboard page

  Scenario: Login unsuccessfully
  And I have logged in as a professor
  And I go to the dashboard page
  Then I should be on the dashboard page

  Scenario: Login successfully into survey
  Given I have logged in as a student for a survey template
  And I go to that survey's page
  Then I should be on that survey's page