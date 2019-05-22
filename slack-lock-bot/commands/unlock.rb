class SlackLockBot::Commands::Unlock < SlackRubyBot::Commands::Base
  command 'unlock' do |client, data, _match|
    user_id = data['user']
    lock_name = data['text'].split.drop(2).join(' ').downcase.strip

    case lock_name
    when 'all'
      locks = ::Lock.where(user_id: user_id)
      text = if locks.present?
               lock_names = locks.map(&:name)
               locks.delete_all
               "#{lock_names.to_sentence} unlocked"
             else
               'no locks found'
             end
    else
      lock = ::Lock.find_by(name: lock_name)
      text = if lock.present?
               if user_id == lock.user_id
                 lock.delete
                 "#{lock_name} unlocked"
               else
                 "#{lock_name} can only be unlocked by <@#{lock.user_id}>"
               end
             else
               'no lock found'
             end
    end

    client.say(
      channel: data.channel,
      text: text,
      thread_ts: data.thread_ts || data.ts
    )
  end
end
