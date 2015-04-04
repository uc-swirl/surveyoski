require 'spec_helper'

describe DashboardController do
  describe "Render the appropriate layouts and templates when logged in" do
      before(:each) do
        user = User.create(:email=> "something", :status => "admin")
        session[:user_id] = user.id
      end
      it 'renders index' do
        visit dashboard_path
        expect(response).to render_template("dashboard") 
      end
  end

  describe "Render the appropriate layouts and templates when not logged in" do
      it 'doesn\'t render index' do
        user = User.create(:email=> "something", :status => "student")
        session[:user_id] = user.id
        visit dashboard_path
        expect(response).to render_template("dashboard/login") 
      end
      it 'doesn\'t render index for non-logged in user' do
        visit dashboard_path
        expect(response).to render_template("dashboard/login") 
      end
  end

end
