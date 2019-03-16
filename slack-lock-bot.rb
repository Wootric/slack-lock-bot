require 'slack-ruby-bot'
Dir['./slack-lock-bot/commands/*.rb'].each { |file| require file }
require 'slack-lock-bot/bot'
