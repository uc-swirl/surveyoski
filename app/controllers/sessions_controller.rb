class SessionsController < ApplicationController
  def create
    flash.keep
    user = User.from_omniauth(env["omniauth.auth"])
    if user != nil
	    session[:user_id] = user.id
      if session[:template_id] != nil
        template = SurveyTemplate.find(session[:template_id])
        redirect_to survey_template_path(template)
      else
        redirect_to root_path
      end
	  else
      session[:user_id] = nil
		  flash[:notice] = "You need to log in with your Berkeley email."
      redirect_to dashboard_login_path
	  end
    # redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

end
