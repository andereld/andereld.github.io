source 'http://rubygems.org'

gem 'rails', '3.1.1'
gem 'unicorn'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.4'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'


group :production do
  gem 'pg'
end

group :development do
  gem 'sqlite3'
  gem 'capistrano'
  gem 'rspec-rails'
end

group :test do
  gem 'sqlite3'
  gem 'rspec'
  gem 'autotest'
end
