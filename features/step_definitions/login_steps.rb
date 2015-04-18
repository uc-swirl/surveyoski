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
  @user = nil
  visit signout_path
end

Given /^I have( | not )logged in as a student for a survey template$/ do |negative|
  course = Course.create!
  @surveyTemplate = course.survey_templates.create(:status => "published")
  @admin = User.create(:email => "prof@berkeley.edu", :status => 'prof', :name => "PROFESSOR")
  @surveyTemplate.user_id = @admin.id
  @surveyTemplate.save
  if negative
    visit signout_path
  end
end 

And (/I go to that survey's page/) do 
  visit survey_template_path(@surveyTemplate)
end

Then (/I go to the page for that course/) do
  @course = Course.find_by_name(@course_name)
  visit edit_course_path(@course)
end

Then (/I should be on the page for that course/) do
  @course = Course.find_by_name(@course_name)
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :should
    current_path.should == edit_course_path(@course)
  else
    assert_equal edit_course_path(@course), current_path
  end
end

Then (/I should be on that survey's page/) do
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :should
    current_path.should == survey_template_path(@surveyTemplate)
  else
    assert_equal survey_template_path(@surveyTemplate), current_path
  end
end

