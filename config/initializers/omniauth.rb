Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'], {
    scope: 'email, profile',
    access_type: 'offline',
    prompt: 'select_account',
    redirect_uri: 'https://yourapp.com/auth/callback'
  }
end
