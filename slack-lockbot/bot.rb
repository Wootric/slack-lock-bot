module SlackLockbot
  class Bot < SlackRubyBot::Bot
    help do
      title 'Lock Bot'
      desc 'This bot helps you lock and unlock things.'

      command 'lock' do
        desc 'Lock something.'
      end

      command 'unlock' do
        desc 'Unlock something.'
      end

      command 'list' do
        desc 'List locks.'
      end
    end
  end
end
