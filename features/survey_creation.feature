Feature: Survey creation
As a course instuctor or TA,
So that I can get feedback from students
I would like to make new course surveys


@javascript
Scenario: Form Creation
  Given I am on the new survey template page
  And I name the survey "Colors"
  And I add a text field "test123"
  Then the survey editor should have a field "test123"
  Then I save the survey
  Then I should see a survey named "Colors" in the database
  And that survey should have a field named "test123"


Scenario:
Given I am an instructor
And I make a new survey
Then I should be on the edit survey page
