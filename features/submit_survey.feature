Feature: submit a survey

  As a survey respondent
  In order to voice my concerns about public transportation
  I would like to be able to fill out and a submit a survey

  Background:
    Given I make a survey template
    And I add a TextQuestionField to that template with question "Department:"
    And I add a TextQuestionField to that template with question "Course:"
    
  Scenario: Fill out a survey
    Given I visit that survey's page
    And I fill in the first field with "CS"
    And I fill in the next field with "169"
    And I press submit
    Then I should be on the survey templates page
    And I should see "Your submission was recorded."
  
  Scenario: Unsuccessfully fill out a survey
    Given I visit that survey's page
    And I fill in the first field with ""
    And I fill in the next field with ""
    And I press submit
    Then I visit that survey's page
    And I should not see "Your submission was recorded."
