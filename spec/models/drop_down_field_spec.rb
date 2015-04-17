require 'spec_helper'

describe DropDownField do
  before(:each) do
    @sel = DropDownField.new(:question_title => "Waiting", :question_description => "Between worlds")
  end

  it "my parent knows about me" do
    expect(SurveyField.descendants).to include(DropDownField)
  end
  
  
  it "store has a title" do
    expect(@sel.question_title).to eq("Waiting")
  end
  it "store has a title" do
    expect(@sel.question_description).to eq("Between worlds")
  end

  it "parses it's options" do
    @sel.parse_options({"1" => {:value => "1", :name => "A"},
      "2" => {:value => "2", :name => "B"}, 
      "3" => {:value => "3", :name => "C"}})

    expect(@sel.field_options).to eq([["A", "1"], ["B", "2"], ["C", "3"]])
  end

  it "has a nice name" do
    expect(DropDownField.nice_name).to eq("Select List")
  end

end
