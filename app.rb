require 'bundler/setup'
# Bundler.require

require 'sinatra'





disable :protection
enable :sessions
set :session_secret, 'secret123'

['settings', 'libraries', 'models', 'routes'].each do |directory|
	Dir["./#{directory}/**/*.rb"].each { |file| require file }
end



# require_directory([
# 'config',
# 'settings',
# 'modules',
# 'helpers',
# 'libraries',
# 'models',
# 'controllers',
# 'routes'
# ])


# configure :production do
#   before do
#     unless request.request_method == 'POST'
#       unless request.url.include? "https://www."
#         redirect "https://www.careertrainingconcepts.com#{request.path}"
#       end
#     end
#   end
# end


