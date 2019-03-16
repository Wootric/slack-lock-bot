$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'dotenv/load'
require 'slack-lock-bot'
require 'app'

Thread.abort_on_exception = true

Thread.new do
  begin
    SlackLockBot::Bot.run
  rescue StandardError => e
    STDERR.puts("ERROR: #{e}")
    STDERR.puts(e.backtrace)
    raise e
  end
end

run SlackLockBot::App
