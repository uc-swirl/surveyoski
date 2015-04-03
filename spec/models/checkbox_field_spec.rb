require 'spec_helper'

describe CheckboxField do
  before(:each) do
    @check = CheckboxField.new(:question_title => "Waiting", :question_description => "Between worlds")
  end

  it "store has a title" do
    expect(@check.question_title).to eq("Waiting")
  end
  it "store has a title" do
    expect(@check.question_description).to eq("Between worlds")
  end

  it "parses it's options" do
    @check.parse_options("A:1\r\nB:2\r\nC:3")

    expect(@check.field_options).to eq([["A", "1"], ["B", "2"], ["C", "3"]])
  end

  it "has a nice name" do
    expect(CheckboxField.nice_name).to eq("Checkbox")
  end
end
