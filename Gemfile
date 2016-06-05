source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '>= 5.0.0.beta3', '< 5.1'

gem 'mysql2', '0.3.19'
gem 'active_hash'
gem 'convergence'
gem 'rubocop'
gem 'faraday'
gem 'rails-i18n'
gem 'active_model_serializers'
gem 'kaminari'
gem 'unicorn'
gem 'activerecord-import'

# 環境設定
gem 'dotenv-rails'
# クロスドメイン
gem 'rack-cors', require: 'rack/cors'
# Rails5.0.0.beta3必須?
gem 'listen'
# 並列処理
gem 'parallel'

gem 'devise_token_auth'

group :development, :test do
  gem 'pry'
  gem 'pry-doc'
  gem 'pry-nav'
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'database_cleaner'
  gem 'factory_girl'
  gem 'factory_girl_rails'
end

group :development do
  gem 'spring'
  gem 'annotate'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'capistrano', '~> 3.2.0', require: false
  gem 'capistrano3-unicorn', require: false
  gem 'capistrano-rails', require: false
  gem 'rvm1-capistrano3', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-maintenance', github: 'capistrano/maintenance', require: false
end

group :test do
  gem 'rspec'
  gem 'simplecov', require: false
  gem 'webmock'
end
