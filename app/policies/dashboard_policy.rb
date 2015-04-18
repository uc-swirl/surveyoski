class DashboardControllerPolicy < ApplicationPolicy
  def index?
    @user.status != "student"  
  end
  def update_user?
  	@user.status != "student"
  end 
end
