require 'spec_helper'

describe SlackLockBot::Bot do
  def app
    SlackLockBot::Bot.instance
  end

  subject { app }

  it_behaves_like 'a slack ruby bot'

  it 'says goodbye' do
    %w(adios bye goodbye).each do |goodbye|
      expect(message: "#{SlackRubyBot.config.user} #{goodbye}").to(
        respond_with_slack_message(goodbye)
      )
    end
  end
end
