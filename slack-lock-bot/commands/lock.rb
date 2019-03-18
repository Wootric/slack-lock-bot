module SlackLockBot
  module Commands
    class Lock < SlackRubyBot::Commands::Base
      command 'lock' do |client, data, _match|
        user_id = data['user']
        user = client.web_client.users_info(user: user_id)['user']
        lock_name = data['text'].split.drop(2).join(' ').downcase

        lock = ::Lock.find_by(name: lock_name)
        text =
          if lock
            other_user = client.web_client.users_info(user: lock.user_id)['user']
            "#{lock_name} already locked by <@#{other_user['id']}>"
          else
            ::Lock.create!(
              name: lock_name,
              user_id: user['id']
            )
            "#{lock_name} locked by <@#{user['id']}>"
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
