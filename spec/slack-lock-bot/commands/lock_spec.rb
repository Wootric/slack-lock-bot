require 'spec_helper'

describe SlackLockBot::Commands::Lock do
  def message(*envs)
    "#{SlackRubyBot.config.user} lock #{envs.join(', ')}"
  end

  it 'creates a lock if it does not exist' do
    expect(message: message('test')).to respond_with_slack_message(
      'test locked by <@user>'
    )
  end

  it 'creates locks if they do not exist' do
    expect(message: message('test', 'test_2')).to respond_with_slack_message(
      'test and test_2 locked by <@user>'
    )
  end

  it 'creates locks if they do not exist and skips locks by other users' do
    create(:lock, name: 'test_2')

    expect(message: message('test', 'test_2')).to respond_with_slack_message(
      "test locked by <@user>\ntest_2 locked by other user"
    )
  end

  it 'does not create a lock if it exists' do
    create(:lock, name: 'test')

    expect(message: message('test')).to respond_with_slack_message(
      'test locked by other user'
    )
  end

  it 'does not create locks if they exist' do
    create(:lock, name: 'test')
    create(:lock, name: 'test_2')

    expect(message: message('test', 'test_2')).to respond_with_slack_message(
      'test and test_2 locked by other users'
    )
  end
end
