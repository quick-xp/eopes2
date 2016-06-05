Rails.application.config.middleware.use OmniAuth::Builder do
  provider :eve_online, ENV['EVE_ONLINE_APP_ID'], ENV['EVE_ONLINE_APP_SECRET']
end
