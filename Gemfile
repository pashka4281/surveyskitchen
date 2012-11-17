source 'https://rubygems.org'

gem 'rails'#, '3.2.3'
gem 'twitter-bootstrap-rails'
gem 'agent_orange' # =>  https://github.com/kevinelliott/agent_orange for detecting browser and os

gem 'jquery-rails'
gem 'bcrypt-ruby', '~> 3.0.0'
gem 'devise'
gem 'devise_invitable'
gem 'carrierwave'
gem 'rails_admin'
# gem 'geokit'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'therubyracer', :platform => :ruby
  gem 'uglifier', '>= 1.0.3'
end

group :development do
  gem 'sqlite3'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'rspec'
end

group :test do
  gem 'factory_girl'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
end

group :production do
  gem 'pg', '0.14.0' #for heroku support
end