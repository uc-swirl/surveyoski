class RadioButtonField < SurveyField
  attr_accessible :radio_button_options


  def self.nice_name
    "Radio Buttons"
  end
end
