require 'slack-ruby-bot'
Dir['./slack-lockbot/commands/*.rb'].each { |file| require file }
require 'slack-lockbot/bot'
