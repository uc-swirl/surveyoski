class DashboardController < ApplicationController
    before_filter :authorize, :except => [:login]
    def authorize
      if not current_user
        redirect_to dashboard_login_path
      end
    end

    def update_user
    end
    def change_user
      # puts params[:email]
      # puts params[:status]
      user = User.find_by_email(params[:email])
      if user
        user.status = params[:status]
        user.save
        flash[:notice] = user.name + " was successfully changed to " + user.status
      else
        flash[:notice] = "User with that email does not exist."
      end
      redirect_to :root
    end

    def index
    end

    def login
      render :action => "login", :layout => "admin_login"
    end
end
