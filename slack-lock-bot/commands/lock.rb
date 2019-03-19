module SlackLockBot
  module Commands
    class Lock < SlackRubyBot::Commands::Base
      command 'lock' do |client, data, _match|
        user_id = data['user']
        lock_name = data['text'].split.drop(2).join(' ').downcase
        lock = ::Lock.find_by(name: lock_name)
        text = if lock
                 "#{lock_name} locked by another user"
               else
                 ::Lock.create!(name: lock_name, user_id: user_id)
                 "#{lock_name} locked by <@#{user_id}>"
               end

        client.say(
          channel: data.channel,
          text: text,
          thread_ts: data.thread_ts || data.ts
        )
      end
    end
  end
end
