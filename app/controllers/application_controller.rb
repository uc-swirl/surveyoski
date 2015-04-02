class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery
  after_action :verify_authorized


  def after_sign_in_path_for(resource)
    if current_user.try(:admin?)
      dashboard_path
    else
      volunteer_path
    end
  end

end
