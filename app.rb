require 'bundler/setup'
Bundler.require

require 'sinatra'
require 'sinatra/chassis/helpers'
require 'dm-timestamps'
require 'dm-validations'
require 'dm-migrations'
require 'pdfkit'

disable :protection
enable :sessions
set :session_secret, 'secret123'


['settings', 'libraries', 'models', 'routes'].each do |directory|
	Dir["./#{directory}/**/*.rb"].each { |file| require file }
end

configure :production do
  before do
    unless request.request_method == 'POST'
      unless request.url.include? "https://www."
        redirect "https://www.hearsurvey.com#{request.path}"
      end
    end
  end
end

DataMapper.finalize
