Given /^I have( | not )logged in as a(?:n?) ([a-zA-Z]+)$/ do |negative, role|
  class User
    attr_accessible :provider, :uid
  end
  User.create!(:provider => "google_oauth2", :uid => "http://xxxx.com/openid?id=118181138998978630963", :status => role)
  visit dashboard_login_path
  click_link 'sign_in'
  puts User.all
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

