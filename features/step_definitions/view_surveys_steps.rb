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