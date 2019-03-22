require 'active_support/core_ext/array'

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
    end

    MatchPhrases = {
      'adios' => 'adios',
      ':wave:' => ':wave:',
      ':success:' => ':success:',
      ':parrot:' => ':parrot:',
      "thanks #{SlackRubyBot.config.user}" => "you're welcome",
      'lunch' => 'enjoy your lunch',
      'dinner' => 'enjoy your dinner',
      'brb' => 'see you soon',
      'chai time' => 'enjoy your chai',
      'running' => 'have a great run',
      'workout' => 'have a great workout',
      '\?' => '42'
    }

    MatchPhrases.each do |pattern, text|
      match(Regexp.new(pattern, true)) do |client, data, match|
        client.say(
          channel: data.channel,
          text: text,
          thread_ts: data.thread_ts || data.ts
        )
      end
    end
  end
end
