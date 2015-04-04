Given /^the following survey template exists$/ do |table|
  @survey = SurveyTemplate.create!
  table.hashes.each do |question|
    @survey.text_question_fields.build(:question_title=>question[:question_title])
  end
  @survey.save!
  @question_number = 0
end

Given /I am on the survey template/ do
  @user = User.create(:email => "test@berkeley.edu", :status => "student")
  ApplicationController.any_instance.stub(:current_user).and_return(@user)
  User.stub(:find).and_return(@user)
  visit survey_template_path(@survey.id)
end

And /^I have already submitted to it/ do
  @survey.participants.build(:email => @user.email)
  @survey.save!
end

When (/^I fill in the fields with (.+)/) do |list|
  list = list.split(",").each {|t| t.strip!; t.gsub!(/\A"|"\Z/, '')}
  list.each do |answer|
    step 'I fill in the next field with "' + answer.to_s + '"'
  end
end

And /I fill in the (?:first|next) field with "(.+)"/ do |value|
  fill_in("submission_" + @survey.survey_fields[@question_number].id.to_s, :with =>value)
  @question_number += 1
end

Given(/^I press submit$/) do
  click_button("survey_submit")
end

Then /^I should see "([^\"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_content(text)
  else
    assert page.has_content?(text)
  end
end

And /my submission should be recorded/ do
  @survey.participants.last.email.should be == @user.email
end

And /I add a TextQuestionField to that survey with question "(.*?)"/ do |question|
  field = @survey.text_question_fields.create!(:question_title => question)
end

And /I add a RadioButtonField to that survey with question "(.*?)"/ do |question|
  field = @survey.radio_button_fields.create!(:question_title => question)
end

And /I add a DropDownField to that survey with question "(.*?)"/ do |question|
  field = @survey.drop_down_fields.create!(:question_title => question)
end