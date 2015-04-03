require 'spec_helper'

describe DropDownField do
  before(:each) do
    @sel = DropDownField.new(:question_title => "Waiting", :question_description => "Between worlds")
  end

  it "store has a title" do
    expect(@sel.question_title).to eq("Waiting")
  end
  it "store has a title" do
    expect(@sel.question_description).to eq("Between worlds")
  end

  it "parses it's options" do
    @sel.parse_options("A:1\r\nB:2\r\nC:3")

    expect(@sel.field_options).to eq([["A", "1"], ["B", "2"], ["C", "3"]])
  end

  it "has a nice name" do
    expect(DropDownField.nice_name).to eq("Select List")
  end

end
