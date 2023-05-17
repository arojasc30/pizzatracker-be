require 'sequel'
require_relative 'app.rb'
require 'puma'
require 'rack/cors'

DB = Sequel.connect(adapter: :postgres, database: 'pizza-api')

require_relative 'models/init'

# CORS middleware configuration
use Rack::Cors do
  allow do
    origins 'http://localhost:3000' # Replace with the actual URL of your React application
    resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options]
  end
end

run PizzaAPI
