class RadioButtonField < SurveyField
  attr_accessible :field_options, :required
  def self.nice_name
    "Radio Buttons"
  end

  def location
  	return "fields/radio_button_field"
  end

end
