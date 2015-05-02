


Then(/^I should see some charts$/) do
  page.should have_selector('svg')
end


Then(/^I test the survey responses page$/) do
  visit all_responses_path(@survey)
end

Then(/^I test the thing$/) do
  visit responses_data_path(@survey)
end


