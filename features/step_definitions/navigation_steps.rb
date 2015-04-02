Given /I go to the (.+) page/ do |page|
  visit path_to(page) 
end

Then /I should be on the (.+) page/ do |page|
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :should
    current_path.should == path_to(page)
  else
    assert_equal path_to(page), current_path
  end
end


