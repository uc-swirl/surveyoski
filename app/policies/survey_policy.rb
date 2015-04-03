class SurveyPolicy < ApplicationPolicy
  attr_reader :user, :survey

  def initialize(user, survey)
    @user = user
   	@survey = survey
  end

  def create?
  	#Surveys must be created by instructors
  	#TAs nor students can create surveys
    user.instructor? 
  end

end