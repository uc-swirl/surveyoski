class DashboardControllerPolicy < Struct.new(:user, :survey_template)
  def index?
    user.status != "student"  
  end
  def update_user?
  	user.status != "student"
  end 
end
