Given (/^there are 11 submissions filled out with (.+)/) do |list|
  # puts page.body
  new_list = list.split(",").each {|t| t.strip!; t.gsub!(/\A"|"\Z/, '')}
  11.times do |i|
    @user = User.create(:email => "tester#{i}@berkeley.edu", :status => "student")
    ApplicationController.any_instance.stub(:current_user).and_return(@user)
    step 'I am on the survey template'
    # puts page.body
    step 'I fill in the fields with "CS 169", "Fox", "2010", "rare:medium"'
    step 'I press submit'
  end
end

Given /I am on the survey responses page/ do
  @survey.status = 'closed'
  @survey.save
  @user = User.create(:email => "test@berkeley.edu", :status => "admin")
  ApplicationController.any_instance.stub(:current_user).and_return(@user)
  User.stub(:find).and_return(@user)
  visit all_responses_path(@survey)
end

Given /I should see 11 responses/ do
  @survey.submissions.length.should be 11
end

Given /I should see a download link to a csv of the responses/ do
  page.should have_content("Download CSV")
end

Given /the survey is closed/ do
  @survey.status = 'closed'
  @survey.save
end