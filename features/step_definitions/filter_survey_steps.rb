Given /^"(.*?)" public surveys and "(.*?)" private surveys exist$/ do |public_count, private_count|
  @course1 = Course.create(:name => "course 1", :department => "MCB", :semester => "Fall", :year => "2013", :active=>true)
  @course2 = Course.create(:name => "course 2", :department => "MCB", :semester => "Fall", :year => "2013", :active=>true)
  Enrollment.create(:user_id => @user.id, :course_id => @course2.id)
  Enrollment.create(:user_id => @user.id, :course_id => @course1.id)
  class SurveyTemplate 
    attr_accessible :user_id , :course_id , :public_survey
  end

  for i in 1...private_count.to_i
    SurveyTemplate.create(:survey_title => "MCB104 course eval#{i}", :user_id => @user.id, :course_id => @course1.id, :public_survey => false)
  end
  for i in 1...public_count.to_i
    SurveyTemplate.create(:survey_title => "MCB102 course eval#{i}", :user_id => @user.id, :course_id => @course1.id, :public_survey => true)
  end
  visit survey_templates_path
end

Then(/^"(.*?)" surveys should (not |)be present$/) do |arg1, negative|
  if /Spring|Fall/ =~ arg1
    courses = Course.where(:semester => arg1)
  elsif /2015|2013/ =~ arg1
  	courses = Course.where(:year => arg1)
  else
  	courses = Course.where(:department => arg1)
  end
  if negative == "not "
  	courses.each do |course|
      page.should_not have_content(course.name)
    end
  else
  	courses.each do |course|
  	  page.should have_content(course.name)
  	end
  end

end

When(/^I filter by semester "(.*?)"$/) do |option|
  within '#filters_semester' do
    all("option[value='#{option}']").each do |thing| thing.click end
  end

  within '#filters_semester' do
    all("option[value='#{option}']").each do |thing| thing.click end
  end
  find("#filter_apply_button").click
end

When(/^I filter by year "(.*?)"$/) do |option|
  within '#date_year' do
    all("option[value='#{option}']").each do |thing| thing.click end
  end
  find("#filter_apply_button").click
  within '#date_year' do
    all("option[value='#{option}']").each do |thing| thing.click end
  end
  find("#filter_apply_button").click
end
