$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'dotenv/load'
require 'slack-lockbot'
require 'app'

Thread.abort_on_exception = true

Thread.new do
  begin
    SlackLockbot::Bot.run
  rescue StandardError => e
    STDERR.puts("ERROR: #{e}")
    STDERR.puts(e.backtrace)
    raise e
  end
end

run SlackLockbot::App
