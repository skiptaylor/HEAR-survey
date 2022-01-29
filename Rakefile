require 'sinatra/chassis/tasks'

require 'sinatra/asset_pipeline/task'
require './app'

Sinatra::AssetPipeline::Task.define! App

Dir["tasks/**/*"].each do |file|
	unless File.directory? file
		file.sub!('tasks', '').sub!('.rake', '')
		Rake.application.rake_require file, paths = ["./tasks"]
	end
end