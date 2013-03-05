source 'https://rubygems.org'

gem 'rails', '3.2.8'

#For Rails 3.1, a JavaScript runtime is needed for Linux Ubuntu. It is not needed for Mac OS X or Windows.  
gem 'execjs'
gem "therubyracer", :platforms => :ruby
  
group :development do
  gem 'mysql2'
end

#For running the app in heroku 
group :production do
  gem 'pg'
  gem 'thin'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'simple_form'
gem 'jquery-rails'
gem 'meta_search'
gem 'less-rails' #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
gem 'twitter-bootstrap-rails'
gem 'mechanize'
gem 'haml-rails'
gem 'rMeetup'
gem 'gmaps4rails'
gem 'twitter'
gem 'oauth'
gem 'topsy'
gem 'tweetstream'
gem 'ancestry' 
gem 'kaminari'

group :test, :development do
  gem 'rspec-rails'
  #gem 'minitest-rails'
  #gem 'spork'
  #gem 'guard-spork'
  #gem 'guard-rspec', ">= 0.4.3"
  #gem 'guard-cucumber', ">= 0.6.1"
  #gem 'guard-rails', ">= 0.0.3"
end
 
group :test do
  gem 'capybara'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'simplecov'
  gem 'fakeweb'
  #gem 'turn' #better output
  #gem 'minitest'
  #gem 'minitest-matchers'
  #gem 'shoulda-matchers'
  #gem 'turn' #better output
  #gem 'guard-minitest'
  #gem 'guard-spork'
  #gem 'spork-testunit'
  #gem 'spin'
end
