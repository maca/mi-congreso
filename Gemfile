source 'https://rubygems.org'

ruby '1.9.3'
gem 'rails', '3.2.8'
gem "thin", ">= 1.4.1"
gem "pg"

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
  gem 'compass-rails', '~> 1.0.3'
  gem 'zurb-foundation', '~> 3.0.9'
end

gem 'pjax_rails'
gem "devise", ">= 2.1.2"
gem 'activeadmin', ">= 0.5.0"
gem "ransack", ">= 0.7.0"
gem "kaminari"

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

group :development do
  gem "hub", ">= 1.10.2", :require => nil
  gem "quiet_assets"
end

group :development, :test do
  gem "rspec-rails", ">= 2.11.0"
  gem "factory_girl_rails", ">= 4.0.0"
end

group :test do
  gem "capybara", ">= 1.1.2"
  gem "database_cleaner", ">= 0.8.0"
  gem "email_spec", ">= 1.2.1"
  gem "cucumber-rails", ">= 1.3.0"
  gem "launchy", ">= 2.1.2"
end
