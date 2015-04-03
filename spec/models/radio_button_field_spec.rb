require 'spec_helper'

describe RadioButtonField do
  before(:each) do
    @rad = RadioButtonField.new(:question_title => "Waiting", :question_description => "Between worlds")
  end

  it "my parent knows about me" do
    expect(SurveyField.descendants).to include(RadioButtonField)
  end
  
  it "store has a title" do
    expect(@rad.question_title).to eq("Waiting")
  end
  it "store has a title" do
    expect(@rad.question_description).to eq("Between worlds")
  end

  it "parses it's options" do
    @rad.parse_options("A:1\r\nB:2\r\nC:3")
    expect(@rad.field_options).to eq([["A", "1"], ["B", "2"], ["C", "3"]])
  end

  it "has a nice name" do
    expect(RadioButtonField.nice_name).to eq("Radio Buttons")
  end
end
