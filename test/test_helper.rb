ENV['EKS_ENV'] = 'test'
require 'minitest/autorun'
require 'minitest/pride' # Nice colors

# Load the application environment
$LOAD_PATH.unshift '/home/ishikawauta/gems/gems/one-for-all-framework-5.2.0'
require 'config/boot'

class Minitest::Test
  # Add helper methods for tests here
  def setup
    # Run migrations or setup DB for tests
  end
end
