class SlackLockBot::Commands::Lock < SlackRubyBot::Commands::Base
  command 'lock' do |client, data, _match|
    user_id = data['user']
    lock_names = data['text'].split.drop(2).join(' ').downcase
      .split(',').map(&:strip)

    locked_by_user = []
    locked_by_other_users = []

    lock_names.each do |lock_name|
      lock = ::Lock.find_by(name: lock_name)

      if lock.present?
        locked_by_other_users << lock.name
      else
        ::Lock.create!(name: lock_name, user_id: user_id)
        locked_by_user << lock_name
      end
    end

    text = ''

    unless locked_by_user.empty?
      text << "#{locked_by_user.to_sentence} locked"
    end

    unless locked_by_other_users.empty?
      text << "\n" unless locked_by_user.empty?
      text << "#{locked_by_other_users.to_sentence} locked by other "
      text << if locked_by_other_users.count == 1
                'user'
              else
                'users'
              end
    end

    client.say(
      channel: data.channel,
      text: text,
      thread_ts: data.thread_ts || data.ts
    )
  end
end
