class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    if user != nil
	    session[:user_id] = user.id
      redirect_to root_path
	  else
      session[:user_id] = nil
		  flash[:notice] = "need to use a Berkeley email"
      redirect_to dashboard_login_path
	  end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

end
