source 'http://rubygems.org'
gemspec

group :test do
  if RUBY_PLATFORM.downcase.include? "darwin"
    gem 'guard-rspec'
    gem 'rb-fsevent'
    gem 'growl'
  end
  gem 'coffee-rails'
end

gem 'spree', '~> 3.1'
gem 'haml', '~> 4.0.7'
gem 'haml-rails', '~> 0.9.0'