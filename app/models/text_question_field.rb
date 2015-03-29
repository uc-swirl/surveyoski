class TextQuestionField < SurveyField
  def is_valid? (response)
    {:value => true}
  end

  def partial
    return "admin/survey_fields/text_question_field.html"
  end

end
