require 'grape'
require 'sequel'
require_relative 'models/init'
require_relative 'controllers/pizzas_controller'
require_relative 'controllers/people_controller'
require_relative 'controllers/consumptions_controller'

DB = Sequel.connect(adapter: :postgres, database: 'pizza')

class PizzaAPI < Grape::API
  format :json
  prefix :api

  mount PizzasController
  mount PeopleController
  mount ConsumptionsController
end

run PizzaAPI
