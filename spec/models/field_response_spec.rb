require 'spec_helper'

describe FieldResponse do 
  it "should create a FieldResponse for a valid text question response" do
    survey = SurveyTemplate.create
    field = TextQuestionField.create(:question_title => "Do you like ponies:")
    survey.survey_fields << field
    submis = survey.submissions.build()
    response = field.field_responses.build(:response => "frootloops")
    submis.field_responses << response
    submis.save
    Submission.find(submis.id).field_responses.where(survey_field_id: field.id).first.response.should eq "frootloops"
  end
end
