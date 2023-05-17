require 'grape'
require 'sequel'

DB = Sequel.connect(adapter: :postgres, database: 'pizza')

class PizzaAPI < Grape::API
  format :json
  prefix :api

  resources :pizzas do
    desc 'Create a pizza'
    params do
      requires :topping, type: String, desc: 'Pizza topping'
    end
    post do
      Pizza.create(topping: params[:topping])
    end

    desc 'Get all pizzas'
    get do
      Pizza.all
    end

    desc 'Get a specific pizza'
    route_param :id do
      get do
        Pizza[params[:id]]
      end
    end

    desc 'Update a pizza'
    route_param :id do
      params do
        requires :topping, type: String, desc: 'Pizza topping'
      end
      put do
        pizza = Pizza[params[:id]]
        pizza.update(topping: params[:topping])
        pizza
      end
    end

    desc 'Delete a pizza'
    route_param :id do
      delete do
        Pizza[params[:id]].destroy
      end
    end
  end

  resources :people do
    desc 'Create a person'
    params do
      requires :name, type: String, desc: 'Person name'
    end
    post do
      Person.create(name: params[:name])
    end

    desc 'Get all people'
    get do
      Person.all
    end

    desc 'Get a specific person'
    route_param :id do
      get do
        Person[params[:id]]
      end
    end

    desc 'Update a person'
    route_param :id do
      params do
        requires :name, type: String, desc: 'Person name'
      end
      put do
        person = Person[params[:id]]
        person.update(name: params[:name])
        person
      end
    end

    desc 'Delete a person'
    route_param :id do
      delete do
        Person[params[:id]].destroy
      end
    end
  end

  desc 'Record pizza consumption'
  params do
    requires :pizza_id, type: Integer, desc: 'Pizza ID'
    requires :person_id, type: Integer, desc: 'Person ID'
  end
  post '/consume' do
    pizza = Pizza[params[:pizza_id]]
    person = Person[params[:person_id]]

    PizzaConsumption.create(pizza: pizza, person: person)
  end

  desc 'Get all pizza consumptions'
  get '/consumptions' do
    PizzaConsumption.all
  end

  desc 'Get streaks of increasing pizza consumption'
  get '/streaks' do
    streaks = []

    # To-do Logic to calculate streaks

    streaks
  end

  desc 'Get the day of the month with the most pizzas consumed'
  get '/most_pizzas_day' do
    day = 0

    # To-do Logic to calculate the day

    day
  end
end

run PizzaAPI
