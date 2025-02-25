# require 'thor'
#
#   class CLI < Thor
#     include Thor::Actions
#
#     def self.source_root
#       "#{File.dirname(__FILE__)}/../.."
#     end
#
#     desc 'create [APP]', 'Creates a new app'
#     def create(app)
#       directory 'template', app
#       File.rename "#{app}/env.example", "#{app}/.env"
#       system "cd #{app} && bundle"
#     end
#   end
