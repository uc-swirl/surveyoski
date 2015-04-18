Given(/^my survey is published$/) do
  @survey.status = "published"
  @survey.save
end
Given (/^the survey is not published$/) do
  @survey.status = "unpublished"
  @survey.save
end