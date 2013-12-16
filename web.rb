require 'bundler'
Bundler.require(:default)

require_relative 'connpool'

class Web < Sinatra::Base
  before do
    ActiveRecord::Base.connection_pool.connections.map(&:verify!)
    ConnPool.checkout
  end

  after do
    ActiveRecord::Base.clear_active_connections!
    ConnPool.checkin
  end

  get '/test' do
    ConnPool.verify
    "foobar!"
    Test.all.to_json
  end

  get '/report' do
    ConnPool.report
  end
end
