source 'https://rubygems.org'
# ruby '1.9.3'

gem 'rails', '~> 4'
gem 'pg', platforms: :ruby
gem 'activerecord-jdbcpostgresql-adapter', platforms: :jruby
gem 'rails_12factor', group: [:production, :staging]

gem 'bcrypt-ruby', require: 'bcrypt'
gem 'ancestry'
gem 'carrierwave'
gem 'fog'
gem 'aws-sdk'
gem 'parslet'
gem 'sentry-raven'
gem 'taps'
gem 'newrelic_rpm', group: :production
gem 'unicorn', platforms: :ruby
gem 'puma',    platforms: :jruby
gem 'mailchimp-api', require: 'mailchimp'
gem 'rspec-rails',        group: %w(development test)
gem 'pry-rails',          group: %w(development test)
gem 'pry-stack_explorer', group: %w(development test)
gem 'faraday_middleware'
gem 'doorkeeper'
gem 'queue_classic', '3.0.0rc'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
end

platforms :rbx do
  gem 'rubysl'
  gem 'racc'
  gem 'iconv', github: 'nurse/iconv', branch: 'master'
  gem 'rubinius-coverage'
end

gem 'iron_cache_rails'
