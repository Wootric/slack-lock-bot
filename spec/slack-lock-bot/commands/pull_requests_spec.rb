require 'spec_helper'

describe SlackLockBot::Commands::PullRequests do
  let!(:message) { "#{SlackRubyBot.config.user} prs" }
end
