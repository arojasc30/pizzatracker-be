ENV['RACK_ENV'] = 'test'

require 'rack/test'
require 'rspec'

# Load the API file
require_relative '../app'

# Configure RSpec
RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.color = true

  def app
    API
  end
end
