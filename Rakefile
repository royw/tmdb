require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "tmdb"
    gem.summary = %Q{TODO}
    gem.email = "roy@wright.org"
    gem.homepage = "http://github.com/royw/tmdb"
    gem.authors = ["Roy Wright"]

    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
    gem.add_dependency('royw-roys_extensions','>= 0.0.2')
    gem.add_dependency('royw-read_page_cache','>= 0.0.1')
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
  spec.spec_opts = ["--color", "--format nested"]
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end


task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION.yml')
    config = YAML.load(File.read('VERSION.yml'))
    version = "#{config[:major]}.#{config[:minor]}.#{config[:patch]}"
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "tmdb #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

desc "stalk github until gem is published"
task :stalk do
  `gemstalk royw tmdb`
end

