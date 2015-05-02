Given(/^"(.*?)" is an active course$/) do |arg1|
  @active_course = Course.create(:name => arg1)
  @active_course.active = true
  @active_course.enrollments.build(:user_id => @user.id)
  @active_course.save

end

Given(/^"(.*?)" is an inactive course$/) do |arg1|
  @inactive_course = Course.create(:name => arg1)
  @inactive_course.active = false
  @inactive_course.enrollments.build(:user_id => @user.id)
  @inactive_course.save

  @user.courses.should include(@active_course, @inactive_course)
end

Given(/^my inactive course has a template$/) do
  @survey = @inactive_course.survey_templates.create(:survey_title => "inactive course survey")
  @survey.user = @user
  @survey.save
end

