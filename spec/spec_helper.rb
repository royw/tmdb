require 'spec'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'tmdb'

$samples_dir = File.dirname(__FILE__) + '/samples'

TMPDIR = File.join(File.dirname(__FILE__), '../tmp')

require 'read_page_cache'
ReadPageCache.attach_to_classes($samples_dir)

Spec::Runner.configure do |config|

end

