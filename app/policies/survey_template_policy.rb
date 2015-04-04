class SurveyTemplatePolicy < Struct.new(:user, :survey_template)
  def index?
    user.status != "student"  
  end
  def create?
  	true
  	#user.status != "student"
  end 
  def new?
  	create?
  end 
  def edit?
  	true
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
  # class Scope < Scope
  #   def resolve
  #     scope
  #   end
  # end
end
