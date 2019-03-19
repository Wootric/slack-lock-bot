$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))

require 'awesome_print'
require 'database_cleaner'
require 'factory_bot'
require 'sinatra/base'
require 'sinatra/activerecord'
require 'simplecov'

Dir['./models/*.rb'].each { |file| require file }

require 'slack-ruby-bot/rspec'
require 'slack-lock-bot'

SimpleCov.start

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    FactoryBot.find_definitions
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning { example.run }
  end
end

ActiveRecord::Base.logger = nil
ActiveRecord::Migration.maintain_test_schema!

VCR.configure do |config|
  config.allow_http_connections_when_no_cassette = true
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :webmock
end
