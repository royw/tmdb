# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{tmdb}
  s.version = "0.1.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Roy Wright"]
  s.date = %q{2009-04-24}
  s.email = %q{roy@wright.org}
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    "LICENSE",
    "README.rdoc",
    "Rakefile",
    "VERSION.yml",
    "lib/tmdb.rb",
    "lib/tmdb/optional_logger.rb",
    "lib/tmdb/tmdb_image.rb",
    "lib/tmdb/tmdb_movie.rb",
    "lib/tmdb/tmdb_profile.rb",
    "spec/samples/api.themoviedb.org/2.0/Movie.imdbLookup?imdb_id=tt0060934&api_key=7a2f6eb9b6aa01651000f0a9324db835",
    "spec/samples/api.themoviedb.org/2.0/Movie.imdbLookup?imdb_id=tt0465234&api_key=7a2f6eb9b6aa01651000f0a9324db835",
    "spec/samples/www.themoviedb.org/image/backdrops/14621/National_Treasure_-_Book_Of_Secrets__XVID___2007_-fanart.jpg",
    "spec/spec_helper.rb",
    "spec/tmdb_image_spec.rb",
    "spec/tmdb_movie_spec.rb",
    "spec/tmdb_profile_spec.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/royw/tmdb}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{TODO}
  s.test_files = [
    "spec/tmdb_profile_spec.rb",
    "spec/spec_helper.rb",
    "spec/tmdb_movie_spec.rb",
    "spec/tmdb_image_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<royw-roys_extensions>, [">= 0.0.2"])
      s.add_runtime_dependency(%q<royw-read_page_cache>, [">= 0.0.1"])
    else
      s.add_dependency(%q<royw-roys_extensions>, [">= 0.0.2"])
      s.add_dependency(%q<royw-read_page_cache>, [">= 0.0.1"])
    end
  else
    s.add_dependency(%q<royw-roys_extensions>, [">= 0.0.2"])
    s.add_dependency(%q<royw-read_page_cache>, [">= 0.0.1"])
  end
end
