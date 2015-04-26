class User < ActiveRecord::Base
  attr_accessible :email, :name, :status
  has_many :enrollments
  has_many :courses, through: :enrollments
  

  @@rankings = {"student" => 1, "ta" => 2, "professor" => 3, "admin" => 4}

  def self.from_omniauth(auth)
    where(auth.slice(:info).slice(:email)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.email = auth.info.email
      user.status ||= "student"
      if (auth.info.email =~ /berkeley.edu$/) == nil
        return nil
      end
      user.save!
    end
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

end

