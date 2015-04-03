class TextQuestionField < SurveyField
  def is_valid? (response)
    {:value => true}
  end

  def self.nice_name
    "Text"
  end



  
end
