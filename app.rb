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
set :session_secret, '66f381c3fed2c48dd6dd749b0b3c5665d4e51f768e4922b23744313aa871441083ec15b6a2320fc773f2791fef72f8c221197f907b355b23894cc2a5f187b2e7'


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
