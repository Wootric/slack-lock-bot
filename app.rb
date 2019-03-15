require 'sinatra/base'
require 'sinatra/activerecord'

Dir['./models/*.rb'].each { |file| require file }

module SlackLockbot
  class App < Sinatra::Base
    register Sinatra::ActiveRecordExtension

    before do
      content_type :json
    end

    get '/' do
      Lock.all.to_json
    end
  end
end
