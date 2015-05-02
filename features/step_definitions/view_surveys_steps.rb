Then /^I should( not)? see survey (.*?)$/ do |negate, survey_number|
	if negate == ' not'
		if page.respond_to? :should
			page.should have_no_content("MCB102 course eval"+survey_number)
			page.should have_no_content("MCB104 course eval"+survey_number)
		else
			assert page.has_no_content?("MCB102 course eval"+survey_number)
		end
	else
		if page.respond_to? :should
			page.should have_content("MCB102 course eval"+survey_number)
			page.should have_content("MCB104 course eval"+survey_number)
		else
			assert page.has_content?("MCB102 course eval"+survey_number)
		end
	end
end

And (/^I click on the (.*?) page for (.*?) surveys$/) do |button_name, public_survey|
	if public_survey == "public"
		within "#my_surveys" do
			if button_name == 'next'
				find(:css, ".next_page").click
			elsif button_name == 'previous'
				find(:css, ".previous_page").click
			end
		end
	elsif public_survey == 'private'
		within "#public_surveys" do
			if button_name == 'next'
				find(:css, ".next_page").click
			elsif button_name == 'previous'
				find(:css, ".previous_page").click
			end
		end
	end
end

