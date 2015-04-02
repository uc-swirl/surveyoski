module OmniAuthTestHelper
  def login_with_oauth_bad_email
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      :provider => 'google_oauth2',
      :uid => '123545',
      :info => { :email => 'example@site.com', :name => 'russell' },
      :credentials => {:token => '1234565', :expires_at => 123456789009999}
      })
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
  end
    def login_with_oauth
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      :provider => 'google_oauth2',
      :uid => '123545',
      :info => { :email => 'example@berkeley.edu', :name => 'russell' },
      :credentials => {:token => '1234565', :expires_at => 123456789009999}
      })
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
  end
end