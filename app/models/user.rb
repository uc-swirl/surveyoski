class User < ActiveRecord::Base
  attr_accessible :email, :name, :status
  
  # def surveyTemplates #This is a dev stub, remove when user is associated with SurveyTemplates
  #   SurveyTemplate.all
  # end


  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.email = auth.info.email
      user.status ||= "student" # default to the most restricted account type 
      if (auth.info.email =~ /berkeley.edu$/) == nil
        return nil
      end
      user.save!
    end
  end

end

