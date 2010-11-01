Rails.application.config.middleware.use OmniAuth::Builder do
  provider :linked_in, 'XXXXXXXXXXXXXXXXXX', 'YYYYYYYYYYYYYYYYYYYYY'
 #provider :facebook, 'APP_ID, 'APP_SECRET'
 #provider :twitter, 'CONSUMER_KEY', 'CONSUMER_SECRET'
end