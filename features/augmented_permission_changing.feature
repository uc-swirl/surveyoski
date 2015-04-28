Feature: Restricting permission-changing abilities
As an admin
So that users are managed properly
Only admin should be able to add users and change user permissions

@omniauth_test_good
Scenario: Professors can't see the Edit Permissions tab
  Given I have logged in as a professor
  Then I should not see "Change Permissions"
@omniauth_test_good
Scenario: TAs can't see the Edit Permissions tab
  Given I have logged in as a ta
  Then I should not see "Change Permissions"
