require 'spec_helper'

describe SlackLockBot::Commands::Stats do
  def message(cmd = '')
    "#{SlackRubyBot.config.user} stats #{cmd}"
  end

  it 'returns stats for a lock' do
    user_id_1 = '5d1f0581'
    user_id_2 = 'ecad5510'

    lock_1 = create(:lock, user_id: user_id_1, name: 'app')
    lock_2 = create(:lock, user_id: user_id_1, name: 'app staging')

    lock_1.destroy!
    lock_2.destroy!

    lock_3 = create(:lock, user_id: user_id_2, name: 'app')
    lock_4 = create(:lock, user_id: user_id_2, name: 'app staging')

    lock_3.destroy!
    lock_4.destroy!

    expect(message: message('app')).to respond_with_slack_message([
      '```',
      '+------+--------+-------------+',
      '| lock | unlock | user_id     |',
      '+------+--------+-------------+',
      '| 1    | 1      | <@5d1f0581> |',
      '| 1    | 1      | <@ecad5510> |',
      '+------+--------+-------------+',
      '```'
    ].join("\n"))
  end

  it 'does not return stats if lock does not exist' do
    expect(message: message('app')).to respond_with_slack_message(
      'no lock found'
    )
  end
end
