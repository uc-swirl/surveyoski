require 'spec_helper'

describe CheckboxField do
  before(:each) do
    @check = CheckboxField.new(:question_title => "Waiting", :question_description => "Between worlds")
  end

  it "my parent knows about me" do
    expect(SurveyField.descendants).to include(CheckboxField)
  end

  it "store has a title" do
    expect(@check.question_title).to eq("Waiting")
  end
  it "store has a title" do
    expect(@check.question_description).to eq("Between worlds")
  end

  it "parses it's options" do
    @check.parse_options({"1" => {:value => "1", :name => "A"},
      "2" => {:value => "2", :name => "B"}, 
      "3" => {:value => "3", :name => "C"}})

    expect(@check.field_options).to eq([["A", "1"], ["B", "2"], ["C", "3"]])
  end

  it "has a nice name" do
    expect(CheckboxField.nice_name).to eq("Checkbox")
  end
end
