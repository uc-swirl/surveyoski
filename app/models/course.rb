class Course < ActiveRecord::Base

  attr_accessible :name, :department, :semester, :year
  has_many :enrollments
  has_many :users, through: :enrollments
  has_many :survey_templates, :dependent => :destroy

  before_save :pepper_up

  def pepper_up
    if active == nil
      active = true
    end
  end

  def remove_user(user_id)

    enrollment = Enrollment.where(:user_id => user_id, :course_id => id).first
    if enrollment != nil
      enrollment.destroy
    else
      # didn't find the enrollment, means you're deleting 
      # someone from a course that doesn't exist in the course
      # puts 'didn\'t find'
      # TODO DEAL WITH THIS CASE.
      return "This person is not part of the course."
    end
  	if users.length == 0
  	  self.destroy
  	  "Your course was deleted."
  	else
      "You have been removed from this course."
  	end
  end
  def add_user(user_id)
    if Enrollment.where(:user_id => user_id, :course_id => id).first == nil
      new_enrollment = enrollments.build(:user_id => user_id)
      new_enrollment.save!
    end
  end
  def add_users(emails)
    clear_enrollments
    emails.each do |email|
      if not User.is_berkeley(email)
        return false
      end
      user = User.find_by_email(email)
      if user == nil
        user = User.create(:email => email, :status => "ta")
      end
      add_user(user.id)
    end
  end
  def clear_enrollments
    enrollments.each do |e| e.destroy end 
  end
end
