require 'spec_helper'

describe DashboardController do
    describe "Render the appropriate layouts and templates when logged in" do
      before(:each) do
        # @request.env["devise.mapping"] = :user
        # @user = sign_in
        login_with_oauth
      end
    it 'Index should render the dashboard layout' do
      get :index
      puts response.body
      expect(response).to render_template(:index)
      #response.should render_template(:index)
    end
  end

    describe "Should not render admin layout, when not logged in" do
      before(:each) do
        #@request.env["devise.mapping"] = :user
        #@user = sign_in(nil)
        login_with_oauth_bad_email
      end
    it 'Index should not render the dashboard layout' do
      get :index
      response.should_not render_template("layouts/dashboard")
    end
  end

end
