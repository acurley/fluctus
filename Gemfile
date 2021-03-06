source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'
ruby '2.0.0'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

gem 'blacklight'
gem 'hydra-head', '~> 6.3.0'

gem "devise"
gem "bootstrap-sass"
gem 'figaro'
gem 'omniauth-google-oauth2'
gem 'simple_form', '~> 3.0.0.rc'
gem "hydra-role-management", "~> 0.1.0"
gem 'phony_rails'
gem 'inherited_resources'

# S3 connector
gem 'aws-s3'

group :development, :test do
  gem 'meta_request'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem "rspec-rails"
  gem 'rspec-mocks'
  gem 'capybara'
  gem 'factory_girl_rails'
  gem 'shoulda-matchers'
  gem 'faker', github: 'stympy/faker'
  gem "jettywrapper"
  gem 'sqlite3'
  gem 'quiet_assets'
  gem 'selenium-webdriver'
  gem 'coveralls', require: false
end

group :production do
  gem 'pg' #Necessary for heroku
  gem "rails_12factor" # Necessary for heroku
end
