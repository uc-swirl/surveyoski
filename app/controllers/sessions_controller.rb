class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    if user != nil
	    session[:user_id] = user.id
	  else
      session[:user_id] = nil
		  flash[:notice] = "need to use a Berkeley email"
	  end
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

end
