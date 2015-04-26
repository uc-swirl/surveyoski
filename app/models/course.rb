class Course < ActiveRecord::Base

  attr_accessible :name, :department, :semester, :year
  has_many :enrollments
  has_many :users, through: :enrollments
  has_many :survey_templates, :dependent => :destroy


  def remove_user(user_id)
    enrollment = enrollments.where(:user_id => user_id).first
    if enrollment != nil
      enrollment.destroy
    end
  	if enrollments.length == 0
  	  self.destroy
  	  "Your course was deleted."
  	else
      "You have been removed from this course"
  	end
  end
end
