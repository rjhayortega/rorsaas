source 'https://rubygems.org'
ruby '2.5.0'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end
gem 'delayed_job_active_record'
gem 'rails', '~> 5.1.1'
gem 'mysql2'
gem 'puma', '~> 3.7'
gem 'sass-rails'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'yaml_db'
gem 'slim-rails'
gem 'kaminari'
gem 'carrierwave'
gem 'mini_magick'
gem 'airbrake'
gem 'dalli'
gem 'typhoeus'
gem 'redis'
gem 'sidekiq'
gem 'gmaps4rails'
gem 'gon', '~> 6.1'
gem 'metainspector'

gem 'devise'
# Use Omniauth Facebook plugin
gem 'omniauth-facebook', '~> 4.0'
gem 'activerecord-session_store', '~> 1.0'

gem 'fog-aws'
gem 'rack-cors', :require => 'rack/cors'

gem 'omniauth-twitter'
gem 'twitter', github: 'sferik/twitter'
gem 'linkedin-oauth2', github: 'pressmatrix/linkedin-oauth2'
gem 'koala'


gem 'foreman'
# gem 'mina-sidekiq'
# gem "sentry-raven"

# Assets
gem 'jquery-rails'
gem 'bootstrap-sass'
gem 'font-awesome-sass', '~> 4.7.0'
gem 'scrollbar-rails'

gem "bulma-rails", "~> 0.4.1.pre"
gem "jquery-fileupload-rails"
gem 'fullcalendar-rails'

gem 'bootstrap3-datetimepicker-rails', '~> 4.17.47'
gem 'whenever'
gem 'stripe'
gem 'simple_form'
gem 'cocoon'
gem 'bitly'


gem 'daemons'
gem 'delayed-web'
gem 'cancancan'
gem 'friendly_id'
gem 'country_select'
gem 'sweet-alert2-rails'
gem 'awesome_print'

# New Gems
gem 'rack-livereload'
gem "guard", ">= 2.2.2"
gem 'guard-livereload'
gem 'guard-minitest'


group :development, :test do
  gem 'byebug'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'capybara', '~> 2.13.0'
  gem 'selenium-webdriver'
  gem 'pry'
end

group :development do
  gem 'mina'
  gem 'mina-puma', require: false
  gem 'mina-delayed_job', require: false

  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'annotate'
  gem 'dotenv', '~> 2.2.1'


  # gem 'better_errors'
  # gem 'binding_of_caller'
  # gem 'meta_request'

  # gem 'terminal-notifier'
  # gem 'terminal-notifier-guard'
  
end

group :test do
  gem 'webmock'
  gem 'vcr'
  gem 'launchy'
end

group :production do
  gem 'rails_12factor'
  gem 'rails_serve_static_assets'
end
