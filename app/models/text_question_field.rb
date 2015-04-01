class TextQuestionField < SurveyField
  def is_valid? (response)
    {:value => true}
  end

  def self.nice_name
    "Text"
  end

  def edit_partial
    return "admin/survey_fields/text_question_field.html"
  end

  
end
