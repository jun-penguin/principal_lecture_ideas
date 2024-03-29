source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.5'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use slim
# gem 'slim-rails'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'

# Seeds
gem 'faker'
gem 'seed-fu'
# Decorator
gem 'draper'

# 認証関連
gem 'devise'
gem 'devise_token_auth'

# CORS
gem 'rack-cors'

# idのhash化
gem 'hashid-rails', '~> 1.0'

# 検索機能
gem 'ransack'

# mailer
gem 'net-imap'
gem 'net-pop'
gem 'net-smtp'

# enum
gem 'enum_help'

# I18n
gem 'rails-i18n'

# admin-lte関連
gem 'font-awesome-sass'
gem 'jquery-rails'

# pagination
gem 'kaminari'

# schema情報の表示
gem 'annotate'

# SEO
gem 'meta-tags'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]

  # Test
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'simplecov', require: false

  # Debugger
  gem 'better_errors'
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-doc'
  gem 'pry-rails'
  gem 'pry-stack_explorer'
  gem 'timecop'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0', require: false
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-commands-rspec'

  # Email
  gem 'letter_opener_web'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'fuubar'
  gem 'rspec-request_describer'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
  gem 'webdrivers' unless ENV['CI']
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
