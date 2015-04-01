class CheckboxField < SurveyField

  def self.nice_name
    "Checkbox"
  end


  def parse_options (options)
    #parses options into an array like [["option1", "value1"], ["option1", "value1"]]  
    lines = options.split("\r\n").map {|x| x.split(":").map {|x| x.strip } }
    self.field_options = lines
  end

end
