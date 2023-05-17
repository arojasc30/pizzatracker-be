require 'sequel'
require_relative 'app.rb'
require 'puma'

DB = Sequel.connect(adapter: :postgres, database: 'pizza-api')

require_relative 'models/init'

run PizzaAPI
