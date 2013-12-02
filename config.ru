require 'bundler'
Bundler.require(:default)

require './api'


run Rack::Cascade.new [API]

