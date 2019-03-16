require 'spec_helper'

describe SlackLockbot::Commands::List do
  def app
    SlackLockbot::Bot.instance
  end

  subject { app }

  it 'lists locks' do
    expect(message: "#{SlackRubyBot.config.user} list").to(
      respond_with_slack_message('no locks')
    )
  end
end
