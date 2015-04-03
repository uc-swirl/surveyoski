When (/I make "([^"]+)" an admin/) do |email|
  visit 'admin/update_user'
  step 'I fill in "email" with "' + email +'"'
  step 'I choose "status_admin"'
  click_button "Update"
end

When (/^I fill in "([^"]*)" with "([^"]*)"$/) do |field, value|
  fill_in(field, :with => value)
end

When (/^(?:|I )choose "([^"]*)"$/) do |field|
  choose(field)
end

Then(/^"(.*?)" should be an admin$/) do |email|
  User.find_by_email(email).status.should be == "admin"
end

Then(/^"(.*?)" should not be an admin$/) do |email|
  if User.find_by_email(email)
    User.find_by_email(email).status.should_not be == "admin"
  end
end
