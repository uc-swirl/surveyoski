Given(/^I clone the survey$/) do
  expect{click_link("Clone this survey")}.to change{SurveyTemplate.count}.by(1)
end

Then(/^I should see another survey$/) do
  page.should have_content("cloned")
end

Then(/^this survey should have the same fields as the first survey$/) do
  original = @survey
  clone = SurveyTemplate.last
  original.survey_fields.each do |f|
    clone.survey_fields.where(question_title: f.question_title).length.should be 1
  end
end

