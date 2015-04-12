class CheckboxField < SurveyField
  attr_accessible :field_options, :required
  def self.nice_name
    "Checkbox"
  end

  def location
  	return "fields/checkbox_field"
  end

end
