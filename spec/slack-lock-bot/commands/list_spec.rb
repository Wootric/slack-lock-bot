require 'spec_helper'

describe SlackLockBot::Commands::List do
  def app
    SlackLockBot::Bot.instance
  end

  subject { app }

  it 'lists locks' do
    expect(message: "#{SlackRubyBot.config.user} list").to(
      respond_with_slack_message('no locks')
    )
  end
end
