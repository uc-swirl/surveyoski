Given /^I have logged in as a(?:n?) ([a-zA-Z]+)$/ do |role|
  class User
    attr_accessible :provider, :uid
  end
  @user = User.create(:email => "test@berkeley.edu", :status => role, :name => "TEST USER")
  ApplicationController.any_instance.stub(:current_user).and_return(@user)
  User.stub(:find).and_return(@user)
  visit dashboard_path
end

Given /^I have not logged in as a(?:n?) (?:[a-zA-Z]+)$/ do
  visit signout_path
end

Given /^I have( | not )logged in as a student for a survey template$/ do |negative|
  @surveyTemplate = SurveyTemplate.create
  if negative
    visit signout_path
  end
end 

And (/I go to that survey's page/) do 
  visit survey_template_path(@surveyTemplate)
end

Then (/I should be on that survey's page/) do
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :should
    current_path.should == survey_template_path(@surveyTemplate)
  else
    assert_equal survey_template_path(@surveyTemplate), current_path
  end
end

