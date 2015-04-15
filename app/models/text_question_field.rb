class TextQuestionField < SurveyField
  attr_accessible :field_options, :required
  # def is_valid? (response)
  #   {:value => true}
  # end


  def self.nice_name
    "Text"
  end


  def location
  	return "fields/text_question_field"
  end
end
