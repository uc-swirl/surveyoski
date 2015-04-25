class Course < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :name, :department, :semester, :year
  has_many :enrollments
  has_many :users, through: :enrollments
  has_many :survey_templates

end
