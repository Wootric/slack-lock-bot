module SlackLockBot
  module Commands
    class List < SlackRubyBot::Commands::Base
      command 'list' do |client, data, _match|
        text = ''

        locks = ::Lock.all
        if locks.count > 0
          locks.each do |lock|
            text += ":lock: #{lock.name} <@#{lock.user_id}>\n"
          end
        else
          text = 'no locks'
        end

        client.say(channel: data.channel, text: text)
      end
    end
  end
end
