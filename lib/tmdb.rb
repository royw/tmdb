$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'rubygems'
require 'open-uri'
require 'date'
require 'xmlsimple'

# royw gems on github
require 'roys_extensions'

# local files
require 'tmdb/optional_logger'
require 'tmdb/tmdb_movie'
require 'tmdb/tmdb_image'
require 'tmdb/tmdb_profile'
