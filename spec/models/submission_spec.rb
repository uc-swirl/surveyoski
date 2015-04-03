require 'spec_helper'

describe Submission do
  before(:each) do
    @field = TextQuestionField.create(:question_title => "Fav artist?", :question_description => "")
    @submission = Submission.create()
    @response = @field.field_responses.build(:response => "Zack Hemsey")
    @submission.field_responses << @response
  end
  it 'has some field_responses'do
    expect(@submission.field_responses.length).to eq(1)
  end
  it 'deletes it\'s field_responses when deleted'do
    @submission.destroy
    expect{FieldResponse.find!(@response.id)}.to raise_error
  end

end
