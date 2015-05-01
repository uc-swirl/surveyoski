Given /^the url should have the uuid instead of the id$/ do
  url = URI.parse(current_url)
  url.to_s.should include(@survey.uuid.to_s)
end