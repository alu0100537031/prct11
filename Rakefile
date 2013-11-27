require "bundler/gem_tasks"
require 'rspec/core/rake_task'
require 'rdoc/task'

$:.unshift File.dirname(__FILE__) + 'lib'
$:.unshift './lib', './spec'

RSpec::Core::RakeTask.new
task :default => :spec



Rake::RDocTask.new do |rd|
   rd.main = "README.md"
   rd.rdoc_files.include("README.md", "lib/**/*.rb")
end