require 'spec_helper'
describe "access top page" do
  it "can sign in user with Google account" do
    visit '/'
    page.should have_content("Sign in with Google")
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2] 
    login_with_oauth
    click_link "Sign in with Google"
    page.should have_content('SurveyOski')
  end
 
  it "can handle authentication error" do
    OmniAuth.config.mock_auth[:google_oauth2] = :invalid_credentials
    visit '/'
    page.should have_content("Sign in with Google")
    click_link "Sign in with Google"
    page.should have_content('Sign in with Google')
  end
 
end