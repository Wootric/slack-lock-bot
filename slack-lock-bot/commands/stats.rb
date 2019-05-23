require 'hirb'

class SlackLockBot::Commands::Stats < SlackRubyBot::Commands::Base
  command 'stats' do |client, data, _match|
    text = ''
    lock_name = data['text'].split.drop(2).join(' ').downcase.strip

    stats = ::Stat.where(name: lock_name)
                  .group_by(&:user_id)
                  .map { |k, vs| [k, vs.tally_by(&:command)] }
                  .to_h

    if stats.present?
      rows = stats.map do |user_id, totals|
        { 'user_id' => "<@#{user_id}>" }.merge(totals)
      end
      text << "```\n"
      text << Hirb::Helpers::AutoTable.render(rows, description: false)
      text << "\n```"
    else
      text = 'no lock found'
    end

    client.say(
      channel: data.channel,
      text: text,
      thread_ts: data.thread_ts || data.ts
    )
  end
end
