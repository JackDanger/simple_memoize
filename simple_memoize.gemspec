Gem::Specification.new do |s|
  s.name = %q{simple_memoize}
  s.version = "1.1.0"

  s.specification_version = 2 if s.respond_to? :specification_version=

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jack Danger Canty"]
  s.date = %q{2008-04-25}
  s.description = %q{Provides in-memory caching of any Ruby method.  It's dead simple and won't get in the way of any of your code. For something more robust that offers persistence try http://github.com/JackDanger/cached_values/ Documentation also available here: http://objectproxy.rubyforge.org/simple_memoize/}
  s.email = ["rubyforge@6brand.com"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
  s.files = ["History.txt", "Manifest.txt", "README.txt", "Rakefile", "lib/simple_memoize.rb", "test/test_simple_memoize.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/JackDanger/simple_memoize/}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{objectproxy}
  s.rubygems_version = %q{1.1.0}
  s.summary = %q{Provides in-memory caching of any Ruby method}
  s.test_files = ["test/test_simple_memoize.rb"]

  s.add_dependency(%q<hoe>, [">= 1.5.1"])
end
