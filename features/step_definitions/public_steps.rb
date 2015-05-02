
When (/^I make the survey public$/) do
  x = find("#slideThree")
  x.trigger('click')
  sleep(4)
  # puts page.body
end