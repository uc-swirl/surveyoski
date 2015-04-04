class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end



  private

  def user_not_authorized
    flash[:notice] = "You are not authorized to perform this action. "
    redirect_to(request.referrer || dashboard_login_path)
  end

end
