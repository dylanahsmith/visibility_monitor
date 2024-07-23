require "bundler/gem_tasks"
require "rake/testtask"
require 'rake/extensiontask'

Rake::ExtensionTask.new("visibility_monitor")

Rake::TestTask.new(test: :compile) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

task :default => :test
