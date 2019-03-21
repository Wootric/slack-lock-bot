require 'spec_helper'

describe SlackLockBot::Bot do
  def app
    SlackLockBot::Bot.instance
  end

  subject { app }

  it_behaves_like 'a slack ruby bot'

  it 'responds to various words' do
    SlackLockBot::Bot::MatchWords.each do |goodbye|
      expect(message: goodbye).to respond_with_slack_message(goodbye)
    end
  end
end
