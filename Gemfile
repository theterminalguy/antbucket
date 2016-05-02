source 'https://rubygems.org'

gem 'rails', '4.2.4'
gem 'rails-api'
gem 'devise'
gem 'active_model_serializers'
gem 'rack-cors', require: 'rack/cors'
gem 'jwt'

group :production do 
  gem 'pg'
end 

group :development, :test do
  gem 'sqlite3'
  gem 'spring'
  gem 'rspec-rails', '~> 3.0'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'factory_girl_rails'
  gem 'ffaker'
  gem 'pry-rails'
  gem 'coveralls', require: false
  gem 'codeclimate-test-reporter', require: nil
  gem 'simplecov', require: false
end
