$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'spec'
require 'spec/autorun'

require 'gom-core'

Spec::Runner.configure do |config|
  config.before :each do
  end

  config.after :each do
  end
end
