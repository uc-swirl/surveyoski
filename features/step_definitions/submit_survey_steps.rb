Given /^the following survey template exists in course "(.+)"$/ do |course_name, table|
  @user ||= User.create(:email => "test@berkeley.edu", :status => "student", :name => "john",  :status => 'published')
  @course = Course.create(:name => course_name)
  @survey = @course.survey_templates.build(:survey_title => "meep", :user_id => user.id)

  table.hashes.each do |question|
    options = question[:options].split(",").map {|x| x.split(":").map {|x| x.strip } }
    case question[:type]
    when "text_question_fields"
      q = @survey.text_question_fields.build(:question_title=>question[:question_title], :required=>question[:required])
    when "radio_button_fields"
      q = @survey.radio_button_fields.build(:question_title=>question[:question_title], :field_options => options, :required=>question[:required])
    when "checkbox_fields"
      q = @survey.checkbox_fields.build(:question_title=>question[:question_title], :field_options => options, :required=>question[:required])
    when "drop_down_fields"
      q = @survey.drop_down_fields.build(:question_title=>question[:question_title], :field_options => options, :required=>question[:required])
    end
    q.save!
  end
  @course.save!
  @question_number = 0
end

Given(/^the following survey template exists$/) do |table|
  @course = Course.create(:name => "untitled")
  @survey = @course.survey_templates.build(:survey_title => "meep")
  table.hashes.each do |question|
    options = question[:options].split(",").map {|x| x.split(":").map {|x| x.strip } }
    case question[:type]
    when "text_question_fields"
      q = @survey.text_question_fields.build(:question_title=>question[:question_title], :required=>question[:required])
    when "radio_button_fields"
      q = @survey.radio_button_fields.build(:question_title=>question[:question_title], :field_options => options, :required=>question[:required])
    when "checkbox_fields"
      q = @survey.checkbox_fields.build(:question_title=>question[:question_title], :field_options => options, :required=>question[:required])
    when "drop_down_fields"
      q = @survey.drop_down_fields.build(:question_title=>question[:question_title], :field_options => options, :required=>question[:required])
    end
    q.save!
  end
  @course.save!
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
  question_type = @survey.survey_fields[@question_number].class
  if question_type == TextQuestionField
    fill_in("submission[#{@survey.survey_fields[@question_number].id}]", :with =>value)
  elsif question_type == CheckboxField
    values = value.split(":")
    values.each do |v|
      check v
    end
  elsif question_type == RadioButtonField
    choose("submission_#{@survey.survey_fields[@question_number].id}_#{value}")
  elsif question_type == DropDownField
    select value, :from => "submission_#{@survey.survey_fields[@question_number].id}"
  end
  @question_number += 1
end

Given(/^I press submit$/) do
  click_button("Submit")
end

Then /^I should see "([^\"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_content(text)
  else
    assert page.has_content?(text)
  end
end


Then /^I should not see "([^\"]*)"$/ do |text|
  if page.respond_to? :should
    page.should_not have_content(text)
  else
    assert page.have_no_content?(text)
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
