Given(/^my survey is published$/) do
  @survey.status = "published"
  @survey.save
end
Given (/^the survey is not published$/) do
  @survey.status = "unpublished"
  @survey.save
end

Given(/^I click on the publish status button$/) do
  page.evaluate_script('window.confirm = function() { return true; }')
  find(:css, ".survey_status_button").click
  sleep 3
end

Then(/^the survey should be published$/) do
  @survey.reload
  @survey.status.should eq("published")
end

