class DropDownField < SurveyField
  
  def self.nice_name
    "Select List"
  end

  attr_accessible :drop_down_options
  def location
  	return "fields/drop_down_field"
  end

end

