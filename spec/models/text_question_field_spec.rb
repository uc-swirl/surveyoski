# require 'spec_helper'

describe TextQuestionField do
  before(:each) do
    @sel = TextQuestionField.new(:question_title => "Waiting", :question_description => "Between worlds")
  end
  
  it "my parent knows about me" do
    expect(SurveyField.descendants).to include(TextQuestionField)
  end
  

  it "store has a title" do
    expect(@sel.question_title).to eq("Waiting")
  end
  it "store has a title" do
    expect(@sel.question_description).to eq("Between worlds")
  end


  it "has a nice name" do
    expect(TextQuestionField.nice_name).to eq("Text")
  end
end