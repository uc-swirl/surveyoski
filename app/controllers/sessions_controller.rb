class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(request.env["omniauth.auth"])
    if user != nil
	    session[:user_email] = user.email
      if session[:template_id] != nil
        template = SurveyTemplate.find(session[:template_id])
        redirect_to survey_template_path(template)
      else
        redirect_to root_path
      end
	  else
      session[:user_email] = nil
		  flash[:notice] = "You need to log in with your Berkeley email."
      redirect_to dashboard_login_path
	  end
  end

  def destroy
    session[:user_email] = nil
    redirect_to root_path
  end

end
