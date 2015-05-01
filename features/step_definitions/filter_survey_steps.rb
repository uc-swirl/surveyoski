Given (/^a bunch of public and private surveys exist$/) do
	@course1 = Course.create(:name => "course 1", :department => "MCB", :semester => "Fall", :year => "2013")
	@course2 = Course.create(:name => "course 2", :department => "MCB", :semester => "Fall", :year => "2013")
	@course3 = Course.create(:name => "course 3", :department => "CS", :semester => "Spring", :year => "2015")
	@course4 = Course.create(:name => "course 4", :department => "CS", :semester => "Spring", :year => "2015")

	otheruser = User.create(:email => "ilovecs@berkeley.edu")
	# @user = User.create(:email => "ilovemcb@berkeley.edu", :status => "professor")

	Enrollment.create(:user_id => @user.id, :course_id => @course1.id)
	Enrollment.create(:user_id => @user.id, :course_id => @course2.id)

	class SurveyTemplate 
		attr_accessible :user_id , :course_id , :public_survey
	end 

	@s1 = SurveyTemplate.create(:survey_title => "MCB102 course eval", :user_id => @user.id, :course_id => @course1.id, :public_survey => false)
	@s2 = SurveyTemplate.create(:survey_title => "MCB102 course eval", :user_id => @user.id, :course_id => @course2.id, :public_survey => false)
	@s3 = SurveyTemplate.create(:survey_title => "MCB102 course eval", :user_id => otheruser.id, :course_id => @course3.id, :public_survey => true)
	@s4 = SurveyTemplate.create(:survey_title => "MCB102 course eval", :user_id => otheruser.id, :course_id => @course4.id, :public_survey => true)
	
	visit survey_templates_path
end

Then(/^my surveys should be present$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^public surveys should not be present$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^"(.*?)" surveys should not be present$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then(/^"(.*?)" surveys should be present$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end
When(/^I filter by checking "(.*?)"$/) do |arg1|
	x = find("#my_surveys")
	check x
end

When(/^I filter by dropdown select "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end
