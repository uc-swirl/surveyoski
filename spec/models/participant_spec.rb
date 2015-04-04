require 'spec_helper'

describe Participant do
  it 'should be able to create participants' do
    alex = Participant.create(:email => "alexlily@berkeley.edu")
    Participant.where(:email => "alexlily@berkeley.edu").should be
  end
  describe 'manage participants and surveys correctly' do
  	before(:each) do
  	  @template = SurveyTemplate.create
  	  @template2 = SurveyTemplate.create
      person = @template.participants.build(:email => "george@fred.com")
      person.save
  	end
    it 'should not add a particpant twice to the same survey' do
      person = @template.participants.build(:email => "george@fred.com")
      expect{person.save!}.to raise_error
    end
    it 'should allow the same email to go to different surveys' do
      person = @template2.participants.build(:email => "george@fred.com")
      expect{person.save!}.to_not raise_error
    end
  end
end
