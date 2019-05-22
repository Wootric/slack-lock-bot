require 'hirb'

class SlackLockBot::Commands::Stats < SlackRubyBot::Commands::Base
  command 'stats' do |client, data, _match|
    text = ''
    stats = {}

    ::Stat.all.each do |stat|
      stats[stat.name] ||= {}
      stats[stat.name][stat.user_id] ||= {}
      stats[stat.name][stat.user_id][stat.command] ||= 0
      stats[stat.name][stat.user_id][stat.command] += 1
    end

    stats.each do |k, v|
      rows = []
      v.each do |user_id, totals|
        row = {}
        row['user_id'] = "<@#{user_id}>"
        row.merge!(totals)
        rows << row
      end

      text << "*#{k}*\n"
      text << "```\n"
      text << Hirb::Helpers::AutoTable.render(rows, description: false)
      text << "\n```\n\n"
    end

    text.strip!

    client.say(
      channel: data.channel,
      text: text,
      thread_ts: data.thread_ts || data.ts
    )
  end
end
