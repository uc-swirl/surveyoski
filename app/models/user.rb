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

  def all_surveys
    admin_surveys unless status != "admin"
    surveys = []
    self.reload
    self.courses.each do |course|
      surveys += course.survey_templates
    end
    surveys
  end
  def admin_surveys
    SurveyTemplate.all
  end

end

