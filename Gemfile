source 'http://rubygems.org'

gem 'rake', '0.8.7'
gem 'rails', '3.1.1'
gem 'unicorn'
gem 'jquery-rails'
gem 'haml'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'maruku'
  gem 'sass-rails',   '~> 3.1.4'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

group :production do
  gem 'pg'
end

group :development do
  gem 'haml-rails'
  gem 'sqlite3'
  gem 'capistrano'
  gem 'rspec-rails'
  gem 'guard-rspec'
end

group :test do
  gem 'sqlite3'
  gem 'rspec'
  gem 'webrat'
  gem 'spork'
end
