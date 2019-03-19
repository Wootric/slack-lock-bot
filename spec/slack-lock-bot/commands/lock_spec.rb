require 'spec_helper'

describe SlackLockBot::Commands::Lock do
  let!(:message) { "#{SlackRubyBot.config.user} lock test" }

  it 'creates a lock if it does not exist' do
    expect(message: message).to respond_with_slack_message(
      'test locked by <@user>'
    )
  end

  it 'does not create a lock if it exists' do
    create(:lock, name: 'test')

    expect(message: message).to respond_with_slack_message(
      'test locked by another user'
    )
  end
end
