require 'spec_helper'

describe SlackLockBot::Bot do
  def app
    SlackLockBot::Bot.instance
  end

  subject { app }

  it_behaves_like 'a slack ruby bot'

  it 'responds to matching phrases' do
    SlackLockBot::Bot::MatchingPhrases.each do |phrase, response_phrase|
      message = "#{phrase} #{SlackRubyBot.config.user}"
      expect(message: message).to respond_with_slack_message(response_phrase)
    end
  end
end
