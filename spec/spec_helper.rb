$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))

require 'awesome_print'
require 'sinatra/base'
require 'sinatra/activerecord'

Dir['./models/*.rb'].each { |file| require file }

require 'slack-ruby-bot/rspec'
require 'slack-lock-bot'
