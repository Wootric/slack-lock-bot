require 'spec_helper'

describe SlackLockBot::Commands::List do
  let!(:message) { "#{SlackRubyBot.config.user} list" }

  it 'lists locks' do
    lock = create(:lock)

    expect(message: message).to respond_with_slack_message(
      ":lock: #{lock.name} <@#{lock.user_id}>\n"
    )
  end

  it 'lists no locks' do
    expect(message: message).to respond_with_slack_message('no locks')
  end
end
