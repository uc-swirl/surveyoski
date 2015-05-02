class Course < ActiveRecord::Base

  attr_accessible :name, :department, :semester, :year, :active
  has_many :enrollments
  has_many :users, through: :enrollments
  has_many :survey_templates, :dependent => :destroy

  before_save :pepper_up

  def pepper_up
    if active == nil
      active = true
      save!
    end
  end

  def remove_user(user_id)

    enrollment = Enrollment.where(:user_id => user_id, :course_id => id).first
    if enrollment != nil
      enrollment.destroy
    else
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

  def self.create_course(params, current_user)
    course = self.find_or_create_by_id(params[:id])
    emails = params[:editor_email].split(/[ |,]+/)
    emails << current_user.email

    ok = course.add_users(emails)
    if not ok
      return "There was an error in updating your course."
    else
      self.update(course.id, :name => params[:course_name], :department => params[:department], 
      :semester => params[:semester], :year => params[:date][:year])
      course.reload
      return "Your course " + course.name.to_s + " was successfully updated "
    end
  end


end
