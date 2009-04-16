require 'spec'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'tmdb'

require 'cache_extensions'

$samples_dir = File.dirname(__FILE__) + '/samples'

TMPDIR = File.join(File.dirname(__FILE__), '../tmp')

Spec::Runner.configure do |config|

end

