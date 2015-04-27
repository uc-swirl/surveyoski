Given /^I make a new course called "(.+)"$/ do |name|
  @courses = @user.courses
  step 'I fill in "course_name" with "' + name +'"'
  step 'I fill in "editor_email" with "' + @user.email + '"'
  click_button 'Submit'
  puts page.body
  @course_name = name
  @courses = @user.courses
  puts @user.id 
  # puts "does this match what is going on :( "
  puts @user.courses.to_yaml
  puts 'WHY IS IT BROKEN.'
  User.all.each do |user|
    puts user.courses.to_yaml
  end
  
end

And /^I delete the first course$/ do
  click_link "delete_course"
end

Given /^"(.+)" is( not | )a user with email "(.+)"$/ do |name, negative, email|
	if negative == " not "
    @new_editor = {:email => email}
	else
  	@new_editor = User.create(:email=>email, :name => name, :status => "professor")
  	@new_editor.name = name
  	@new_editor.save!
  end
end

And /^I add (?:him|her) to the first course$/ do
  puts @new_editor
  puts page.body
	click_link @course_name

	if @new_editor.class == User
    step 'I fill in "editor_email" with "' + @new_editor.email + '"'
  else
  	step 'I fill in "editor_email" with "' + @new_editor[:email] + '"'
  end
  click_button "Submit"
  
end