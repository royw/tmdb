require 'spec'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'tmdb'

$samples_dir = File.dirname(__FILE__) + '/samples'

TMPDIR = File.join(File.dirname(__FILE__), '../tmp')

require 'cache_extensions'
CacheExtensions.attach_to_read_page_classes($samples_dir)

Spec::Runner.configure do |config|

end

