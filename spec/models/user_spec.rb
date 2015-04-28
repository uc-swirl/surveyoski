require 'spec_helper'

describe User do
  it "Should be able to find a user by name" do
  	  ben = User.create(:name => "Ben", :email => "marcojoemontagna@gmail.com")
      User.where(:name => "Ben").first.should_not be_nil
  end

  it "Shouldn't find nonexistant users" do
    User.where(:name => "Ben").first.should be_nil
  end

  it "responds to #name" do
	  ben = User.create(:name => "Ben Poodles", :email => "marcojoemontagna@gmail.com")
 	  expect(ben).to respond_to(:name)
  end

  it "responds to #status" do
    ben = User.create(:name => "Ben Poodles", :email => "marcojoemontagna@gmail.com", :status => "student")
    expect(ben).to respond_to(:status)
  end

  it "responds to #email" do
  	ben = User.create(:name=> "Ben Poodles", :email => "marcojoemontagna@gmai.com")
   	expect(ben).to respond_to(:email)
  end

  describe 'connecting user to surveys' do
    before(:each) do
      @oski = FactoryGirl.create(:user)
      course1 = FactoryGirl.create(:course)
      course2 = FactoryGirl.create(:course)
      enrollment = course1.enrollments.build(:user_id => @oski.id)
      enrollment.save!
      course1.survey_templates.build
      course1.survey_templates.build
      course1.save!
      course2.survey_templates.build
      course2.survey_templates.build
      course2.save!
    end
    it 'shows only my surveys' do 
      expect(@oski.all_surveys.length).to be(2)
      expect(SurveyTemplate.all.length).to be(4)
    end
    it 'see all surveys associated with my courses' do
      orig = @oski.all_surveys.length
      course = @oski.courses.first
      course.survey_templates.build
      course.save!
      expect(@oski.all_surveys.length).to be(orig + 1)
    end

  end
end
