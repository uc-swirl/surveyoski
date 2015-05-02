class User < ActiveRecord::Base
  attr_accessible :email, :name, :status
  has_many :enrollments
  has_many :courses, through: :enrollments
  
  validates :email, uniqueness: true
  @@rankings = {"student" => 1, "ta" => 2, "professor" => 3, "admin" => 4}
  def is_admin?
    status == "admin"
  end
  def is_professor?
    status == "professor"
  end
  def self.is_berkeley(email)
    (email =~ /berkeley.edu$/) != nil
  end
  def self.from_omniauth(auth) # where(:email => "sldjfl@berkeley.edu") => [<>, <>], 
    puts "INFO"
    puts auth.slice(:info)
    x = auth.slice(:info)
    puts "EMAIL"
    puts auth.info.email    

    user = find_or_create_by_email(auth.info.email)
    user.provider = auth.provider
    user.uid = auth.uid
    user.name = auth.info.name
    user.oauth_token = auth.credentials.token
    user.oauth_expires_at = Time.at(auth.credentials.expires_at)
    user.email = auth.info.email
    user.status ||= "student"
    if not is_berkeley(auth.info.email)
      return nil
    end
    user.save!
    
  end

  def all_surveys(filter_hash = nil)
    admin_surveys unless status != "admin"
    self.reload
    filtered_courses = if filter_hash then self.courses.where(filter_hash) else self.courses end
    SurveyTemplate.where(:course_id => filtered_courses)
  end
  def admin_surveys
    SurveyTemplate.all
  end
  def active_courses(keep)
    courses.select {|course|
      course == keep or course.active
    }
  end

end

