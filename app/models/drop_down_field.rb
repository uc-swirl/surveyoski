class DropDownField < SurveyField
  attr_accessible :drop_down_options
  def location
  	return "fields/drop_down_field"
  end
  def options
  	options = drop_down_options.split(', ')
  	revised_options = []
  	count = 1
  	options.each do |option|
  		revised_options << [option, count]
  		count += 1
  	end
  	revised_options
  end
end
