class DashboardControllerPolicy < ApplicationPolicy
  def index?
    @user.status != "student"  
  end
  def update_user?
  	@user.status == "admin"
  end 

end
