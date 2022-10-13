source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

# Devise is a flexible authentication solution for Rails based on Warden.
gem 'devise', '~> 4.8'
# Translations for the devise gem
gem 'devise-i18n'
# Make sure Bootstrap 4 is installed, either as a Ruby gem or using CDN
gem 'devise-bootstrap-views', '~> 1.0'
# Haml-rails provides Haml generators for Rails 5. It also enables Haml as the templating engine 
gem "haml-rails", "~> 2.0"
# Converts HTML into Haml.
gem 'html2haml', '~> 2.2'
# The most popular HTML, CSS, and JavaScript framework for developing responsive, mobile first projects on the web.
gem 'bootstrap', '~> 5.1'
# AutoStripAttributes helps to remove unnecessary whitespaces from ActiveRecord or ActiveModel attributes.
gem "auto_strip_attributes", "~> 2.6"
# will_paginate provides a simple API for performing paginated queries with Active Record, DataMapper and Sequel, and includes helpers for rendering pagination links in Railsweb apps.
gem 'will_paginate', '~> 3.1.0'
# This gem integrates the Twitter Bootstrap pagination component with the will_paginate pagination gem. Supports Rails and Sinatra.
gem 'will_paginate-bootstrap', '~> 1.0'
# Promise based HTTP client for the browser.
gem 'axios_rails', '~> 0.14.0'
# Paranoia does this by setting a deleted_at field to the current time when you destroy a record, and hides it by scoping all queries on your model to only include records which do not have a deleted_at field.
gem 'paranoia', '~> 2.6'
# Wicked is a Rails engine for producing easy wizard controllers

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.5'
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Shim to load environment variables from .env into ENV in development.
gem 'dotenv-rails', require: 'dotenv/rails-now'
# Use Active Storage variant
gem 'image_processing', '~> 1.2'
gem "aws-sdk-s3", require: false

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver', '>= 4.0.0.rc1'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

group :production do
  gem 'pg', '~> 1.1'
end