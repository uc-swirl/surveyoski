class CheckboxField < SurveyField
  attr_accessible :checkbox_options
  def location
  	return "fields/checkbox_field"
  end
  def options
  	return checkbox_options.split(', ')
  end
end
