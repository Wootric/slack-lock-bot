$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))

require 'awesome_print'
require 'database_cleaner'
require 'factory_bot'
require 'sinatra/base'
require 'sinatra/activerecord'

Dir['./models/*.rb'].each { |file| require file }

require 'slack-ruby-bot/rspec'
require 'slack-lock-bot'

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

ActiveRecord::Migration.maintain_test_schema!
