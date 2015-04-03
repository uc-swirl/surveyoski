require 'spec_helper'

describe SurveyField do
  before(:each) do
    @field = SurveyField.new(:question_title => "Waiting", :question_description => "Between worlds")
  end

  it "store has a title" do
    expect(@field.question_title).to eq("Waiting")
  end
  it "store has a title" do
    expect(@field.question_description).to eq("Between worlds")
  end

  it "blank field is valid " do
    expect(@field.is_valid? "" ).to be_true
  end

  it "nice name errors" do
    expect { @field.nice_name }.to raise_error
  end

  it "to throw error on " do
    expect { SurveyField.nice_name }.to raise_error
  end

  it "as_json to throw error " do
    expect { @field.as_json }.to raise_error
  end
end
