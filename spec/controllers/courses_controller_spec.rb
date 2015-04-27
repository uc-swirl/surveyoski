require 'spec_helper'

describe CoursesController do
	describe 'making and updating courses' do
	  before(:each) do
      user = FactoryGirl.create(:user, :email => "example#{Random.rand(12423)}@berkeley.edu")
      session[:user_email] = user.email
	  end
	  describe 'making a new course' do
	    it 'can create a new course' do 
	      expect{
	      	put 'create', :course_name => "new course", :editor_email => "",
	      	:department => "Computer Science", :date => {:year => "2014"}, :semester => "Spring"
	      }.to change{Course.all.length}.by(1)
	    end
	  end
	  describe 'updating course' do
	  	before(:each) do
	  		@course = FactoryGirl.create(:course)
	  		@u1 = FactoryGirl.create(:user, :email => "example#{Random.rand(12423)}@berkeley.edu")
	  		@u1.email = "pepper@berkeley.edu"
	  		@u1.save
	  		@u2 = FactoryGirl.create(:user, :email => "example#{Random.rand(12423)}@berkeley.edu")
	  		@u2.email = "fifi@stanford.edu"
	  		@u2.save
	  		@u3 = FactoryGirl.create(:user, :email => "example#{Random.rand(12423)}@berkeley.edu")
	  		@u3.email = "lily@cmu.edu"
	  		@u3.save
	  	end
		  it 'updates instead of making a new course' do
		  	expect{
		  		put 'create', :id => @course.id, :course_name => "new course", :editor_email => "",
		    	:department => "Computer Science", :date => {:year => "2014"}, :semester => "Spring"
		    }.to change{Course.all.length}.by(0)
		  end
		  it 'updates the users correctly' do
		  	put 'create', :id => @course.id, :course_name => "new course", :editor_email => "pepper@berkeley.edu, fifi@stanford.edu, lily@cmu.edu",
		    	:department => "Computer Science", :date => {:year => "2014"}, :semester => "Spring"
		    # puts "course"
		    # puts Course.find(@course.id).name
		    # puts "users"
		    # puts Course.find(@course.id).users
		    expect(Course.find(@course.id).users).to include(@u1)
		  end
	  end
	end
end
