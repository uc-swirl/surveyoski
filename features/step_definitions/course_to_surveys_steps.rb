
And /^(?:am|is) in course "(.+)"$/ do |course_name|
  puts Course.all
  Course.find_by_name(course_name).users << @user
  @user.save!
  expect(@user.courses.length).to be(1)
end

Given(/^course "(.*?)" has survey "(.*?)"$/) do |course_name, survey_name|
  course = Course.create!(:name => course_name)
  course.survey_templates.build(:survey_title => survey_name)
  course.save!
end

Given(/^"(.*?)" is in course "(.*?)"$/) do |name, course_name|
  person = User.find_by_name(name)
  enrollment = Course.find_by_name(course_name).enrollments.build(:user_id => person.id)
  enrollment.save!
  puts person.courses
end


Given(/^I am in course "(.*?)"$/) do |course_name|
  enrollment = Course.find_by_name(course_name).enrollments.build(:user_id => @user.id)
  enrollment.save!
end

Given(/^I am not in course "(.*?)"$/) do |course_name|
  course = @user.courses.select {|course| course.name == course_name }
  puts course
end
