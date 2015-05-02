class DashboardController < ApplicationController
    before_filter :authorize_user, :except => [:login]
    def authorize_user
      if not current_user
        redirect_to dashboard_login_path
      end
    end

    def update_user
      authorize :dashboard_controller
    end
    def change_user
      user = User.find_by_email(params[:email])
      if user
        user.status = params[:status]
        user.save

        flash[:notice] = "#{user.name} was successfully changed to " + user.status
      else
        User.create(:email => params[:email], :status => params[:status])
        flash[:notice] = "A new user has been created."
      end
      redirect_to :root
    end

    def index
      authorize :dashboard_controller
      render :action => "index", :layout => "dashboard"
    end

    def login
      render :action => "login", :layout => "admin_login"
    end
end
