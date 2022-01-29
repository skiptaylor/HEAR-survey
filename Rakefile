require 'sinatra/chassis/tasks'

Dir["tasks/**/*"].each do |file|
	unless File.directory? file
		file.sub!('tasks', '').sub!('.rake', '')
		Rake.application.rake_require file, paths = ["./tasks"]
	end
end