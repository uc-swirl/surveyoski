require 'spec_helper'

describe "Tables are associated correctly" do
  before (:each) do 
    @t = SurveyTemplate.create
    @q1 = TextQuestionField.create(:question_title => "Name:")
    @q1.survey_template_id = @t.id
    @q2 = TextQuestionField.create(:question_title => "Email:")
    @q2.survey_template_id = @t.id
    
    @s1 = Submission.create
    @s1.survey_template_id = @t.id

    @s2 = Submission.create
    @s2.survey_template_id = @t.id
    
    @r1 = FieldResponse.new(:response => "Alex")
    @r1.submission_id = @s1.id
    @r1.survey_field_id = @q1.id
    @r1.save  
    @r2 = FieldResponse.new(:response => "Marco")
    @r2.submission_id = @s2.id
    @r2.survey_field_id = @q2.id
    @r2.save
    @r3 = FieldResponse.new(:response => "dluu@gmail.com")
    @r3.submission_id = @s1.id
    @r3.survey_field_id = @q1.id
    @r3.save
    @r4 = FieldResponse.new(:response => "mabinogiben@gmail.com")
    @r4.submission_id = @s2.id
    @r4.survey_field_id = @q2.id   
    @r4.save
    
  end
  it "template can access its fields" do
    @t.survey_fields.should be
  end
  it "survey field knows its responses" do
    @q1.field_responses.should be
  end
  it "response knows its field type" do
    expect(@r1.survey_field.type).to be == "TextQuestionField"
  end
  it "response knows its question" do 
    expect(@r1.survey_field.question_title).to be == "Name:"
  end

end
