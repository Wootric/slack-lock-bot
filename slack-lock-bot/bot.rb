require 'active_support/core_ext/array'
require_relative 'core_ext/enumerable'

module SlackLockBot
  module Commands; end

  class Bot < SlackRubyBot::Bot
    help do
      title 'Lock Bot'
      desc 'This bot helps you lock and unlock things.'

      command 'lock <thing, another_thing>' do
        desc 'Lock one or more things.'
      end

      command 'unlock <thing | all>' do
        desc 'Unlock one thing or all things.'
      end

      command 'list' do
        desc 'List locks.'
      end

      command 'stats <thing>' do
        desc 'Get stats for one thing.'
      end
    end
  end
end
