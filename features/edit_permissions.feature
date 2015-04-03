Feature: Change permissions
	As an admin 
  So that professors and TAs can start creating surveys
  I would like to change the permissions for users

  Background:
    Given the following users exist:
    | name     | email               | status  |
    | Ben Luu  | ben@poodles.com     | admin   |
    | Alex Lin | alexlily@gmail.com  | student |

Scenario: give a user admin privileges 
  Given I am on the admin login page
  And I have logged in as ben@poodles.com
  When I make "Alex Lin" an admin
  Then I should see "Succesfully updated permissions"
  And "alexlily@gmail.com" should be an admin

Scenario: fail to update permissions
  Given I am on the admin login page
  And I have logged in as ben@poodles.com
  When I make "Marco" an admin
  Then I should see "Could not update"
  And "Marco" should not be an admin
