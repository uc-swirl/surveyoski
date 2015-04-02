Given /^I have( | not )logged in as a(?:n?) ([a-zA-Z]+)$/ do |negative, role|
  @user = User.create!(:email => "something@berkeley.edu", :status => role)
  if negative != "not"
    ApplicationController.any_instance.stub(:current_user).and_return(@user)
  end
end

Given /^I have( | not )logged in as a student for a survey template$/ do |negative|
  if negative != "not"
    ApplicationController.any_instance.stub(:current_user).and_return(@user)
    SurveyTemplatesController.any_instance.stub(:authorize).and_return(true)
  end
    @surveyTemplate = SurveyTemplate.create
end 

