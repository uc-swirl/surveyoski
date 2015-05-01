
When (/^I make the survey public$/) do
  x = find("#slideThree")
  x.trigger('click')
  puts page.body
end