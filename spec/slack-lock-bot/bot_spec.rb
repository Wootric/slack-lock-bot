require 'spec_helper'

describe SlackLockbot::Bot do
  def app
    SlackLockbot::Bot.instance
  end

  subject { app }

  it_behaves_like 'a slack ruby bot'
end
