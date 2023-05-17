require 'grape'
require_relative 'controllers/pizzas_controller'
require_relative 'controllers/people_controller'
require_relative 'controllers/consumptions_controller'

class PizzaAPI < Grape::API
  format :json

  mount PizzasController
  mount PeopleController

  namespace :reports do
    desc 'Get streaks of increasing pizza consumption'
    get :consumption_streaks do
      PizzasController.consumption_streaks
    end

    desc 'Get the day of the month with the most pizza consumption'
    get :most_pizzas_day do
      PizzasController.most_pizzas_day
    end
  end
end
