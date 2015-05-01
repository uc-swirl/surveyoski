
require 'spec_helper'

describe SurveyTemplate do
  describe 'having basic access rights' do
    it 'has access to its survey_fields' do 
      s = SurveyTemplate.create
      s.text_question_fields.build(:question_title => "Name:")
      s.text_question_fields.build(:question_title => "Phone:")
      s.text_question_fields.build(:question_title => "Address:")
      s.save
      s.survey_fields.length.should be 3
    end
  end
  describe 'formating survey submissions into a csv-formatted string' do
    before :each do
      @s = SurveyTemplate.create(:status => 'published')
      @q1 = @s.text_question_fields.build(:question_title => "Favorite Color")
      @q2 = @s.text_question_fields.build(:question_title => "Number of Pets")
      @s.save
    end
    it 'gives a proper message when there have been no submissions yet' do
      @s.status = 'closed'
      @s.save
      @s.submissions_to_csv.should eq "There were no submissions."
    end
    it 'gives a proper message when there has been one submission' do
      submis = @s.submissions.build
      r1 = submis.field_responses.build(:response => "Ocean Blue")
      r1.survey_field_id = @q1.id
      r2 = submis.field_responses.build(:response => "0")
      r2.survey_field_id = @q2.id
      submis.save
      @s.status = 'closed'
      @s.save
      @s.submissions_to_csv.should eq "There was only one submission."
    end
    it 'does not format results if there have been fewer than 11 submissions' do
      5.times do
        submis = @s.submissions.build
        r1 = submis.field_responses.build(:response => "Blue")
        r1.survey_field_id = @q1.id
        r2 = submis.field_responses.build(:response => "4")
        r2.survey_field_id = @q2.id
        submis.save
      end
      @s.status = 'closed'
      @s.save
      @s.submissions_to_csv.should eq "There were only five submissions."
    end
    it 'formats submissions into csv string when there have been more than 10 responses' do
      3.times do
        submis = @s.submissions.build
        r1 = submis.field_responses.build(:response => "Lime Green")
        r1.survey_field_id = @q1.id
        r2 = submis.field_responses.build(:response => "25")
        r2.survey_field_id = @q2.id
        submis.save
      end
      3.times do
        submis = @s.submissions.build
        r1 = submis.field_responses.build(:response => "Magenta")
        r1.survey_field_id = @q1.id
        r2 = submis.field_responses.build(:response => "2")
        r2.survey_field_id = @q2.id
        submis.save
      end
      6.times do
        submis = @s.submissions.build
        r1 = submis.field_responses.build(:response => "Pink")
        r1.survey_field_id = @q1.id
        r2 = submis.field_responses.build(:response => "14")
        r2.survey_field_id = @q2.id
        submis.save
      end
        @s.status = 'closed'
        @s.save
        r = @s.submissions_to_csv
        r.should include("Favorite Color,Number of Pets\n")
        r.should include("Lime Green,25\n")
        r.should include("Magenta,2\n")
        r.should include("Pink,14\n")
    end
    it 'appends an empty string when a submission does not have a response for a survey_field' do
      11.times do
        submis = @s.submissions.build
        r1 = submis.field_responses.build(:response => "Lime Green")
        r1.survey_field_id = @q1.id
        submis.save
      end
      @s.status = 'closed'
      @s.save
      r = @s.submissions_to_csv
      r.should include("Lime Green,\n")
    end
  end
  describe 'formatting emails of participants' do
    it 'formats emails of survey participants in csv string' do
      s = SurveyTemplate.create(:status => 'published')
      p1 = double('participant')
      p2 = double('participant')
      p3 = double('participant')
      s.should_receive(:participants).and_return([p1, p2, p3])
      p1.should_receive(:email).and_return("pancakes@berkeley.edu")
      p2.should_receive(:email).and_return("pizza@berkeley.edu")
      p3.should_receive(:email).and_return("potatoes@berkeley.edu")
      s.status = 'closed'
      s.save
      s.participants_to_csv.should eq "Student Email\npancakes@berkeley.edu\npizza@berkeley.edu\npotatoes@berkeley.edu\n"
    end
  end
end
