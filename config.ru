require 'bundler'
Bundler.require(:default)

require './api'
require './web'


run Rack::Cascade.new [API, Web]

