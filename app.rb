require 'bundler/setup'
Bundler.require

require 'sinatra'
require 'sinatra/chassis/helpers'
require 'dm-timestamps'
require 'dm-validations'
require 'dm-migrations'

disable :protection
enable :sessions
set :session_secret, 'secret123'


['settings', 'libraries', 'models', 'routes'].each do |directory|
	Dir["./#{directory}/**/*.rb"].each { |file| require file }
end



DataMapper.finalize
