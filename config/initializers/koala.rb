Koala.configure do |config|
  # config.access_token = MY_TOKEN
  # config.app_access_token = MY_APP_ACCESS_TOKEN
  config.app_id = '760639790720386'
  config.app_secret = Rails.application.secrets.facebook_key
  # See Koala::Configuration for more options, including details on how to send requests through
  # your own proxy servers.
end
