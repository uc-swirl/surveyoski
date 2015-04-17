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
    @rad.parse_options({"1" => {:value => "1", :name => "A"},
      "2" => {:value => "2", :name => "B"}, 
      "3" => {:value => "3", :name => "C"}})

    expect(@rad.field_options).to eq([["A", "1"], ["B", "2"], ["C", "3"]])
  end

  it "has a nice name" do
    expect(RadioButtonField.nice_name).to eq("Radio Buttons")
  end
end
