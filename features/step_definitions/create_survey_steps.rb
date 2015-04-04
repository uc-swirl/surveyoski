Given /^(?:|I )am a(?:|n) (.+)$/ do |user|
	(['student', 'admin', 'instructor', 'ta'].include? user.downcase).should == true
    @user = User.create(:email => "test@berkeley.edu", :status => user.downcase)
    ApplicationController.any_instance.stub(:current_user).and_return(@user)
  	User.stub(:find).and_return(@user)
end

And /^(?:|I )make a new survey/ do
	visit path_to('new')
end

Then /^(?:|I ) should be on (.+)$/ do |page_name|
	current_path = URI.parse(current_url).path
	if current_path.respond_to? :should
		current_path.should == path_to(page_name)
	else
		assert_equal path_to(page_name), current_path
	end
end