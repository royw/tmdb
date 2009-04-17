$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'rubygems'
require 'open-uri'
require 'date'
require 'xmlsimple'

require 'tmdb/optional_logger'
require 'tmdb/tmdb_movie'
require 'tmdb/tmdb_profile'
require 'module_extensions'
require 'string_extensions'
require 'file_extensions'
require 'object_extensions'
