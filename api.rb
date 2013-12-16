require 'bundler'
Bundler.require(:default)

require_relative 'connpool'
require_relative 'models/test'

class API < Grape::API
  version 'v1', using: :header, vendor: 'test'
  format :json
  prefix '/api'


  before do
    ActiveRecord::Base.connection_pool.connections.map(&:verify!)
    ConnPool.checkout
  end

  after do
    ActiveRecord::Base.clear_active_connections!
    ConnPool.checkin
  end


  resource :tests do

    desc "Test"
    params do
    end
    get :open do
      ConnPool.verify
      { "test_var" => @test_var }
      Test.all
    end


    desc "Report"
    params do
    end
    get :report do
      ConnPool.report
      {}
    end
  end
end
