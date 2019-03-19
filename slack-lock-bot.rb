require 'slack-ruby-bot'
require 'slack-lock-bot/bot'

Dir['./slack-lock-bot/commands/*.rb'].each { |file| require file }
