Before('@omniauth_test_good') do
  OmniAuth.config.test_mode = true
 
  # the symbol passed to mock_auth is the same as the name of the provider set up in the initializer
  OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      "provider"=>"google_oauth2",
      "uid"=>"http://xxxx.com/openid?id=118181138998978630963",
      "info"=>{"email"=>"test@berkeley.edu", "name"=>"Test User"},
      "credentials"=>{"token"=>"12398735987", "expires_at"=>12312412472837}
  })
end
 
After('@omniauth_test_good') do
  OmniAuth.config.test_mode = false
end

Before('@omniauth_test_bad') do
  OmniAuth.config.test_mode = true
 
  # the symbol passed to mock_auth is the same as the name of the provider set up in the initializer
  OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      "provider"=>"google_oauth2",
      "uid"=>"http://xxxx.com/openid?id=118181138998978630963",
      "info"=>{"email"=>"test@notberkley.com", "name"=>"Test User"},
      "credentials"=>{"token"=>"12398735987", "expires_at"=>12312412472837}
  })
end
 
After('@omniauth_test_bad') do
  OmniAuth.config.test_mode = false
end