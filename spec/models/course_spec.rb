require 'spec_helper'

describe Course do
  before(:each) do
  	@course = FactoryGirl.create(:course)
  	@u1 = FactoryGirl.create(:user)
  	@u1.email = "one@berkeley.edu"
  	@u1.save
  	@u2 = FactoryGirl.create(:user)
  	@u2.email = "two@berkeley.edu"
  	@u2.save
  	@u3 = FactoryGirl.create(:user)
  	@u3.email = "three@berkeley.edu"
  	@u3.save
  end
  describe 'users already in course' do
    before(:each) do
      e1 = @course.enrollments.build(:user_id => @u1.id)
      e1.save
	  e2 = @course.enrollments.build(:user_id => @u2.id)
	  e2.save
	  e3 = @course.enrollments.build(:user_id => @u3.id)
	  e3.save
    end
    it 'knows its users' do
  	  expect(@course.users).to match_array([@u1, @u2, @u3])
    end
    describe 'remove users' do
      it 'correctly removes a user' do
      	orig = @course.users.length
      	@course.remove_user(@u1.id)
      	Course.find(@course.id).users.length.should be(orig - 1)
      	expect(Course.find(@course.id).users).to_not include(@u1)
      end
      it 'doesn\'t kill the course when there are still users left' do
      	orig = Course.all.length
      	@course.remove_user(@u1.id)
      	Course.all.length.should be(orig)
      end
      it 'kills the course only when you remove the last user' do
      	orig = Course.all.length
      	Course.find(@course.id).remove_user(@u1.id)
      	Course.find(@course.id).remove_user(@u2.id)
      	Course.all.length.should be(orig)
      	Course.find(@course.id).remove_user(@u3.id)
      	Course.all.length.should be(orig-1)
      end
      it 'deals with the case of removing a nonexistant users' do
        orig = Course.all.length
        orig_users = @course.users.length
        user = User.create(:email => "a_unique_email@berkeley.edu")
        @course.remove_user(user.id)
        Course.all.length.should be orig
        @course.users.length.should be orig_users
      end
    end
  end
  describe 'users not in course yet' do
    describe 'add users' do
  	  it 'adds one user correctly' do
  	  	orig = @course.users.length
  	  	@course.add_user(@u1.id)
  	  	Course.find(@course.id).users.length.should be(orig+1)
  	    expect(Course.find(@course.id).users).to include(@u1)
  	  end
  	  it 'adds a group of users correctly' do
  	  	orig = @course.users.length
  	  	@course.add_users([@u1.email,@u2.email,@u3.email])
  	  	Course.find(@course.id).users.length.should be(orig + 3)
  	  	expect(Course.find(@course.id).users).to match_array([@u1,@u2,@u3])
  	  end
  	  it 'creates users when they do not exist previously' do
        orig = @course.users.length
        @course.add_users(["curiousgeorge@berkeley.edu"])
        Course.find(@course.id).users.length.should be(orig + 1)
        expect(User.find_by_email("curiousgeorge@berkeley.edu")).to be
      end

    end
  end  
end