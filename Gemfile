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
gem 'puma', group: %w(development)
gem 'faraday_middleware'

group :test do
  # gem 'coveralls'
end

platforms :rbx do
  gem 'rubysl'
  gem 'racc'
  gem 'iconv', github: 'nurse/iconv', branch: 'master'
  gem 'rubinius-coverage'
end
