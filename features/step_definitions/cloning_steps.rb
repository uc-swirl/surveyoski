Given(/^I clone the survey$/) do
  # puts page.body
  @orig = SurveyTemplate.all.length
  course = @user.courses.create
  
  Timeout.timeout(Capybara.default_wait_time) do
    loop until page.evaluate_script('jQuery.active').zero?
  end

  within "#my_surveys" do
    first(".clone_button").click
  end
  puts "found the first thing"
  within "#clone_dialog" do
    find("#clone_submit_button").click
  end
  page.should have_content "SurveyOski"
  page.should_not have_content "slow down, rspec. and let phantomjs finish cloning the survey."
end

Then(/^I should see another survey$/) do
  @user.courses.each do |c| puts c; puts c.survey_templates; end
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
