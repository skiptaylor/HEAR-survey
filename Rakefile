require 'sinatra/chassis/tasks'

namespace :puma do

	desc 'Start Puma'
	task :start, :port do |t, args|
		system "puma -p #{args.port} -C config/puma.rb"
	end
	
	desc 'Stop Puma'
	task :stop do
		if pid = File.read('./tmp/puma.pid').to_i
		  system "kill -9 #{pid}"
		end
	end

end
