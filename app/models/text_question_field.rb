class TextQuestionField < SurveyField
  def is_valid? (response)
    {:value => true}
  end
  def location
  	return "fields/text_question_field"
  end
end
