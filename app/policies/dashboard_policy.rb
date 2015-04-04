class DashboardControllerPolicy < Struct.new(:user, :survey_template)
  def index?
    user.status != "student"  
  end
  def update_user?
  	user.status != "student"
  end 
  # class Scope < Scope
  #   def resolve
  #     scope
  #   end
  # end
end
