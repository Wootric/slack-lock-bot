require 'spec_helper'

describe SlackLockBot::Bot do
  def app
    SlackLockBot::Bot.instance
  end

  subject { app }

  it_behaves_like 'a slack ruby bot'

  it 'responds to matching words' do
    SlackLockBot::Bot::MatchWords.each do |word|
      expect(message: word).to respond_with_slack_message(word)
    end
  end

  it 'responds to matching phrases' do
    SlackLockBot::Bot::MatchPhrases.each do |phrase, response_phrase|
      message = "#{phrase} #{SlackRubyBot.config.user}"
      expect(message: message).to respond_with_slack_message(response_phrase)
    end
  end
end
