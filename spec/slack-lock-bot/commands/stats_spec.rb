require 'spec_helper'

describe SlackLockBot::Commands::Stats do
  def message(cmd = '')
    "#{SlackRubyBot.config.user} stats #{cmd}"
  end

  it 'returns stats' do
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

    expect(message: message).to respond_with_slack_message([
      '*app*',
      '```',
      '+------+--------+-------------+',
      '| lock | unlock | user_id     |',
      '+------+--------+-------------+',
      '| 1    | 1      | <@5d1f0581> |',
      '| 1    | 1      | <@ecad5510> |',
      '+------+--------+-------------+',
      '```',
      '',
      '*app staging*',
      '```',
      '+------+--------+-------------+',
      '| lock | unlock | user_id     |',
      '+------+--------+-------------+',
      '| 1    | 1      | <@5d1f0581> |',
      '| 1    | 1      | <@ecad5510> |',
      '+------+--------+-------------+',
      '```',
    ].join("\n"))
  end
end
