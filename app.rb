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

  namespace :reports do
    desc 'Get all pizza consumptions'
    get :pizza_consumptions do
      ConsumptionsController.all.to_json
    end

    desc 'Get streaks of increasing pizza consumption'
    get :increasing_consumption_streaks do
      ConsumptionsController.calculate_increasing_streaks.to_json
    end

    desc 'Get the day of the month with the most pizza consumption'
    get :most_pizzas_day do
      ConsumptionsController.calculate_most_pizzas_day.to_json
    end
  end
end

run PizzaAPI
