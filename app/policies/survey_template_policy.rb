class SurveyTemplatePolicy < Struct.new(:user, :survey_template)
  def index?
    user.status != "student"  
  end
  def create?
  	user.status != "student"
  end 
  def new?
  	create?
  end 
  def edit?
  	user.status != "student"
  end
  def show?
  	true
  end
  def all_responses?
  	user.status == "professor" or user.status == "admin"
  end
  def participants?
  	user.status == "professor" or user.status == "admin"
  end
end
