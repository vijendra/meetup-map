Twitter.configure do |config|
  config.consumer_key = APP_CONFIG['consumer_key']
  config.consumer_secret = APP_CONFIG['consumer_secret']
  config.oauth_token = APP_CONFIG['oauth_token']
  config.oauth_token_secret = APP_CONFIG['oauth_token_secret']
end

TweetStream.configure do |config|
  config.consumer_key       = APP_CONFIG['consumer_key']
  config.consumer_secret    = APP_CONFIG['consumer_secret']
  config.oauth_token        = APP_CONFIG['oauth_token']
  config.oauth_token_secret = APP_CONFIG['oauth_token_secret']
  config.auth_method        = :oauth
end

#For initializing client for individual user
#@client = Twitter::Client.new(:oauth_token => "a user's OAuth token", :oauth_token_secret => "a user's OAuth secret")
