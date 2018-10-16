source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.10'

# Performance
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Better syntax
# Use jquery as the JavaScript library
gem 'jquery-rails'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'

# For reading Excel (xls and xlsx) files
# gem 'roo'
gem 'roo-xls'

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'

# Write excel files
gem 'rubyzip', '>= 1.2.1'
gem 'axlsx', git: 'https://github.com/randym/axlsx.git', ref: 'c8ac844'
gem 'axlsx_rails', '~> 0.5.2'

# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# For haml syntax
gem 'haml'

# For creating haml files when performing scaffold
gem 'haml-rails'

# Style and order
# Sass version of bootstrap
gem 'bootstrap-sass'

# Sass version of font awesome icons
gem 'font-awesome-sass'

# Forms made easy
gem 'simple_form'

# Cocoon dynamic nested attributes forms
gem "cocoon"

# For pagination
gem 'will_paginate'

# Editable tables
gem 'bootstrap-editable-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# User permissions provided by CanCanCan (active development branch)
gem 'cancancan', '~> 1.10'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
group :production, :staging do
  # For postgres
  gem 'pg'

  # Use Puma as the app server
  gem 'puma', '~> 3.11'

  # For assets in heroku
  gem 'rails_12factor'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'

  # For testing
  gem 'rspec-rails'

  # For test records
  gem 'factory_girl_rails'
end
