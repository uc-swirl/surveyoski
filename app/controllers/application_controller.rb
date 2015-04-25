class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  helper_method :current_user

  def current_user
    @current_user ||= User.find_by_email(session[:user_email]) if session[:user_email]
  end

  private

  def user_not_authorized (exception)
    policy_name = exception.policy.class.to_s
    if policy_name == "SurveyTemplatePolicy"
      flash[:notice] = "This survey is not published."
    else
      flash[:notice] = "You are not authorized to perform this action."
    end
    redirect_to(request.referrer || dashboard_login_path)
  end
end
