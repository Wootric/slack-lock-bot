require 'spec_helper'

describe SlackLockBot::Commands::Unlock do
  def message(env = 'test')
    "#{SlackRubyBot.config.user} unlock #{env}"
  end

  it 'deletes one lock' do
    create(:lock, name: 'test', user_id: 'user')

    expect(message: message).to respond_with_slack_message(
      'test unlocked by <@user>'
    )
  end

  it 'deletes many locks' do
    create(:lock, name: 'test', user_id: 'user')
    create(:lock, name: 'test_2', user_id: 'user')

    expect(message: message('all')).to respond_with_slack_message(
      'test, test_2 unlocked by <@user>'
    )
  end

  it 'does not delete any locks if they do not exist' do
    expect(message: message('all')).to respond_with_slack_message(
      'no locks found'
    )
  end

  it 'does not delete a lock if it is owned by another user' do
    create(:lock, name: 'test', user_id: 'user_2')

    expect(message: message).to respond_with_slack_message(
      'test can only be unlocked by <@user_2>'
    )
  end

  it 'does not delete a lock if does not exist' do
    expect(message: message).to respond_with_slack_message(
      'no lock found'
    )
  end
end
