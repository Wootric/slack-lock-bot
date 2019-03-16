require 'spec_helper'

describe SlackLockBot::Bot do
  def app
    SlackLockBot::Bot.instance
  end

  subject { app }

  it_behaves_like 'a slack ruby bot'
end
