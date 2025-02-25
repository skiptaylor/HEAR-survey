desc 'Run the app in an IRB session'
task :irb do
  require 'irb'
  ARGV.clear
  IRB.start
end
