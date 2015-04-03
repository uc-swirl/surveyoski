class RadioButtonField < SurveyField
  attr_accessible :radio_button_options
  def location
  	return "fields/radio_button_field"
  end
  def options
  	return radio_button_options.split(', ')
  end
end
