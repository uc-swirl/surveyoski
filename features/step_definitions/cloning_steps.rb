Given(/^I clone the survey$/) do
  @orig = SurveyTemplate.all.length
  course = @user.courses.create
  first("img.clone_button").click
  first(:button, "Submit").click()
  page.should have_content "SurveyOski"
  page.should_not have_content "slow down, rspec. and let phantomjs finish cloning the survey."
end

Then(/^I should see another survey$/) do
  page.should have_content("cloned")
end

Then(/^this survey should have the same fields as the first survey$/) do
  original = @survey
  clone = SurveyTemplate.last
  expect(SurveyTemplate.all.length).to be(@orig + 1)
  original.survey_fields.each do |f|
    clone.survey_fields.where(question_title: f.question_title).length.should be 1
  end
end
