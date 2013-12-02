require 'bundler'
Bundler.require(:default)


class API < Grape::API
  version 'v1', using: :header, vendor: 'test'
  format :json
  prefix '/api'


  before do
    #ActiveRecord::Base.connection_pool.connections.map(&:verify!)
    puts "before"
  end

  after do
    #ActiveRecord::Base.clear_active_connections!
    puts "after"
  end


  resource :tests do

    desc "Test"
    params do
    end
    get :open do
      { "test_var" => @test_var }
    end
  end
end
