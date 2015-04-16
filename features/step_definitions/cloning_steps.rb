Given(/^I clone the survey$/) do

  course = @user.courses.create
  Course.stub(:find_by_name).and_return(course)
  expect{
    click_link("Clone this survey")
    }.to change{SurveyTemplate.count}.by(1)
    # puts SurveyTemplate.all
end

Then(/^I should see another survey$/) do
  # puts "user surveys"
  puts @user.all_surveys
  # puts "end of user surveys"
  # puts "all surveys"
  # puts SurveyTemplate.all
  # puts "end of all surveys"
  page.should have_content("cloned")
end

Then(/^this survey should have the same fields as the first survey$/) do
  original = @survey
  clone = SurveyTemplate.last
  original.survey_fields.each do |f|
    clone.survey_fields.where(question_title: f.question_title).length.should be 1
  end
end
