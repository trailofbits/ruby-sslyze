begin
  require 'bundler/setup'
rescue LoadError => e
  abort e.message
end

require 'rake'
require 'bundler/gem_tasks'

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new

task :test    => :spec
task :default => :spec

require 'yard'
YARD::Rake::YardocTask.new  
task :doc => :yard

file 'spec/sslyze.xml' do
  sh 'sslyze.py --xml_out spec/sslyze.xml --regular --timeout 5 twitter.com github.com:443'
end
