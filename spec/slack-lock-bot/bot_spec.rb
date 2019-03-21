require 'spec_helper'

describe SlackLockBot::Bot do
  def app
    SlackLockBot::Bot.instance
  end

  subject { app }

  it_behaves_like 'a slack ruby bot'

  it 'responds to various words' do
    SlackLockBot::Bot::MatchWords.each do |word|
      expect(message: word).to respond_with_slack_message(word)
    end
  end
end
