module SlackLockBot
  module Commands
    class List < SlackRubyBot::Commands::Base
      command 'list' do |client, data, _match|
        locks = ::Lock.all
        text = ''

        if locks.present?
          locks.each_with_index do |lock, index|
            text += ":lock: #{lock.name} <@#{lock.user_id}>"
            text += "\n" if index != locks.size - 1
          end
        else
          text = 'no locks'
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
