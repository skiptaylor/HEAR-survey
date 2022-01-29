require 'bundler/setup'
# Bundler.require

require 'sinatra'
require 'dm-timestamps'
require 'dm-validations'
require 'dm-migrations'



['settings', 'libraries', 'models', 'routes'].each do |directory|
	Dir["./#{directory}/**/*.rb"].each { |file| require file }
end



DataMapper.finalize
