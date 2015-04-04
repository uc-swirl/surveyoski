class CheckboxField < SurveyField

  def self.nice_name
    "Checkbox"
  end

  attr_accessible :checkbox_options
  def location
  	return "fields/checkbox_field"
  end

end
