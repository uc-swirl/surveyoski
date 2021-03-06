Feature: Change permissions
	As an admin 
  So that professors and TAs can start creating surveys
  I would like to change the permissions for users

Background:
  Given the following users exist:
  | name     | email                      | status   |
  | Inigo M  | bestswordsman@berkeley.edu | student  |

@omniauth_test_good
Scenario: give a user admin privileges 
  Given I have logged in as an admin
  When I make "bestswordsman@berkeley.edu" an admin
  Then I should see "was successfully changed to admin"
  And "bestswordsman@berkeley.edu" should be an admin

@omniauth_test_good
Scenario: adding a nonexistent user
  Given I have logged in as an admin
  When I make "wesley@berkeley.edu" an admin
  Then I should see "A new user has been created."
  And "wesley@berkeley.edu" should be an admin
