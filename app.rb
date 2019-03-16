require 'sinatra/base'
require 'sinatra/activerecord'

Dir['./models/*.rb'].each { |file| require file }

module SlackLockBot
  class App < Sinatra::Base
    register Sinatra::ActiveRecordExtension

    before do
      content_type :json
    end

    get '/' do
      ''
    end
  end
end
