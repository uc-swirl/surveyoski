require 'spec_helper'

describe SessionsController do
	it 'does not allow non-berkeley emails' do
	  login_with_oauth_bad_email
      get :create
	  expect(response).to redirect_to :dashboard_login
	end

	it 'allows berkeley emails' do
      login_with_oauth
      get :create
	  expect(response).to redirect_to :root
	end

end
