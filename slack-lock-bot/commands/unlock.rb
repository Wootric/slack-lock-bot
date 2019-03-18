module SlackLockBot
  module Commands
    class Unlock < SlackRubyBot::Commands::Base
      command 'unlock' do |client, data, _match|
        user_id = data['user']
        user = client.web_client.users_info(user: user_id)['user']
        lock_name = data['text'].split.drop(2).join(' ').downcase

        case lock_name
        when 'all'
          locks = ::Lock.where(user_id: user_id)
          text =
            if locks.present?
              lock_names = locks.map { |lock| lock.name }
              locks.delete_all
              "#{lock_names.join(', ')} unlocked by <@#{user_id}>"
            else
              'nothing to unlock'
            end

          client.say(
            channel: data.channel,
            text: text,
            thread_ts: data.thread_ts || data.ts
          )
        else
          lock = ::Lock.find_by(name: lock_name)
          text =
            if lock
              other_user = client.web_client.users_info(user: lock.user_id)['user']
              if user['id'] == other_user['id']
                lock.delete
                "#{lock_name} unlocked by <@#{user['id']}>"
              else
                "#{lock_name} can only be unlocked by <@#{other_user['id']}>"
              end
            else
              "#{lock_name} lock not found"
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
end
