Given(/^I delete the field "(.*?)"$/) do |field_name| 
  find(:xpath, "//button[contains(@name, 'delete-#{field_name}')]").click()

end

Then(/^the survey template should not have a field "(.*?)"$/) do |field_name|
  page.should have_no_selector(:css, '.survey-field-' + field_name)
end


Then(/^the survey template should( not)? require "(.*?)" to be filled out\.$/) do |req_not, field_name|
  found_field = @survey.survey_fields.find {|field| field.question_title == field_name}
   expect(found_field.required).to eq(req_not != "not")
end

Given(/^I drag "(.*?)" to be (above|below) "(.*?)"$/) do |field1, ab, field2|
  #It's currently not easily possible to test drag and drop via Capybara
  if ab == "below"
    temp = field1
    field1 = field2
    field2 = temp
  end

  page.execute_script("
    var first = jQuery(\"[name='question-container-#{field1}']\").detach();
    var second = jQuery(\"[name='question-container-#{field2}']\");
    first.insertBefore(second);
    SurveyField.prototype.refreshIDs();
    ");
end

Then(/^"(.*?)" should come before "(.*?)" on the edit survey page$/) do |field1, field2|
  @user = User.create(:email => "test@berkeley.edu", :status => "admin")
  ApplicationController.any_instance.stub(:current_user).and_return(@user)
  User.stub(:find).and_return(@user)
  visit edit_survey_template_path @survey.id

  page.body.index("question-container-#{field1}").should < page.body.index("question-container-#{field2}")
end


Given(/^I am on the edit survey template$/) do
  @user = User.create(:email => "test@berkeley.edu", :status => "admin")
  ApplicationController.any_instance.stub(:current_user).and_return(@user)
  User.stub(:find).and_return(@user)
  visit edit_survey_template_path @survey.id
end

Given(/^I mark "(.*?)" as required$/) do |field_name|
  found_field = @survey.survey_fields.find {|field| field.question_title == field_name}
  found_field.required = true
  @survey.save!
end

Given /I am on the new survey template page/ do
  @user = User.create(:email => "test@berkeley.edu", :status => "admin")
  ApplicationController.any_instance.stub(:current_user).and_return(@user)
  User.stub(:find).and_return(@user)
  visit new_survey_template_path
  @field_id = 0
end

Given /I save the survey/ do 
  click_button 'Send survey'
end

Given /I name the survey "(.+)"/ do |name|
  fill_in "form_name", :with => name
end

Given /that field should have the following options "(.+)"/ do |options|
  options = (options.split (",")).map {|x| x.split}
  options.each do |val| 

    expect(@found_field.field_options).to include(val[0].split(":"))
  end
  
end

Given /I should see a survey named "(.+)" in the database/ do |name|
  @found = SurveyTemplate.find_by_survey_title!(name)
end

Given /that survey should have a field named "(.+)"/ do |name|
  expect(@found.survey_fields.any? do |x| 
    if x.question_title == name
      @found_field = x
    end
    x.question_title == name
  end).to be_true
end

Given /I add a text field "(.+)"/ do |name| 
  fill_in 'new_field_name', :with => name
  select('Text', :from => 'new_field_type')
  click_button 'Add question'
  @field_id +=1 
end

Given /I add a select field "(.+)" with options "(.+)"/ do |name, options| 
  fill_in 'new_field_name', :with => name
  select('Select List', :from => 'new_field_type')
  click_button 'Add question'
  fill_in "fields[" + @field_id.to_s + "][options]", :with => options.sub(",", "\n")
  
  @field_id +=1 
end

Given /I add a radio button field "(.+)"/ do |name| 
  fill_in 'new_field_name', :with => name
  select('Radio Buttons', :from => 'new_field_type')
  click_button 'Add Question'
  @field_id +=1 
end


Given /I add a Checkbox field "(.+)"/ do |name| 
  fill_in 'new_field_name', :with => name
  select('Checkbox', :from => 'new_field_type')
  click_button 'Add Question'
  @field_id +=1 
end



Given /the survey editor should have a field "(.+)"/ do |name| 
  within(:css, '.question_container') {
    expect(page).to have_css("input[value='"+name+"']")
  }
end

Given /^(?:|I )am a(?:|n) (.+)$/ do |user|
  (['student', 'admin', 'instructor', 'ta'].include? user.downcase).should == true
    @user = User.create(:email => "test@berkeley.edu", :status => user.downcase)
    ApplicationController.any_instance.stub(:current_user).and_return(@user)
    User.stub(:find).and_return(@user)
end

And /^(?:|I )make a new survey/ do
  visit path_to('new')
end

Then /^(?:|I ) should be on (.+)$/ do |page_name|
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :should
    current_path.should == path_to(page_name)
  else
    assert_equal path_to(page_name), current_path
  end
end
