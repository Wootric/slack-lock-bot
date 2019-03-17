require 'spec_helper'

describe SlackLockBot::Commands::List do
  let!(:message) { "#{SlackRubyBot.config.user} list" }

  it 'lists no locks' do
    expect(message: message).to respond_with_slack_message('no locks')
  end

  it 'lists one lock' do
    lock = create(:lock)

    expect(message: message).to respond_with_slack_message(
      ":lock: #{lock.name} <@#{lock.user_id}>"
    )
  end

  it 'lists many locks' do
    lock_1 = create(:lock)
    lock_2 = create(:lock)

    expect(message: message).to respond_with_slack_message(
      ":lock: #{lock_1.name} <@#{lock_1.user_id}>\n" +
      ":lock: #{lock_2.name} <@#{lock_2.user_id}>"
    )
  end
end
