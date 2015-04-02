Feature: Admin Dashboard

  As a course staff or admin,
  So that I can access the various features of Survey Oski
  I want to be shown a dashboard with links to admin features. 

  Background:
    Given the following users exist:
    | name     | email                  | status
    | Ben Luu  | ben@berkeley.edu       | admin
    | Alex Lin | alexlily@berkeley.edu  | student

  Scenario: I should not be able to go to the admin dashboard if I'm not logged in as an admin
    Given I am on the admin dashboard
    Then I should be redirected to admin login

  Scenario: I should not be able to go to the admin dashboard if I am logged as a volunteer
    Given I am on the admin login page
    Given I have logged in as alex@berkeley.edu
    Given I am on the admin dashboard
    Then I should be redirected to the volunteer page

  Scenario: I should see links to available admin actions.
    Given I am on the admin login page
    Given I have logged in as ben@poodles.com with password 123password
    And I am on the admin dashboard
    Then there should be some links to admin actions

  Scenario: I should be able to logout
    Given I am on the admin login page
    Given I have logged in as ben@poodles.com with password 123password
    And I am on the admin dashboard
    When I follow "Logout"
    Then I should not be logged in
