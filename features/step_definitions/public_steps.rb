
When (/^I make the survey public$/) do
  x = find("#slideThree")
  x.trigger('click')
  sleep(2)
  # puts page.body
end