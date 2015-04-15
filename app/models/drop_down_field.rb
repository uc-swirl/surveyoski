class DropDownField < SurveyField
  attr_accessible :field_options, :required  
  def self.nice_name
    "Select List"
  end

  def location
  	return "fields/drop_down_field"
  end

end

