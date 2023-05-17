require_relative 'entities'

class PizzasController < Grape::API
  resource :pizzas do
    desc 'Return all pizza consumptions'
    get do
      present Pizza.all, with: PizzaEntity
    end

    desc 'Return a pizza consumption by ID'
    params do
      requires :id, type: Integer, desc: 'Pizza ID'
    end
    route_param :id do
      get do
        present Pizza[params[:id]], with: PizzaEntity
      end
    end

    desc 'Add a new pizza consumption'
    params do
      requires :topping, type: String, desc: 'Pizza topping'
      requires :person_id, type: Integer, desc: 'Person ID'
    end
    post do
      pizza = Pizza.create(topping: params[:topping], date: DateTime.now, person_id: params[:person_id])
      present pizza, with: PizzaEntity
    end

    desc 'Update a pizza by ID'
    params do
      requires :id, type: Integer, desc: 'Pizza ID'
      requires :topping, type: String, desc: 'Pizza topping'
    end
    put ':id' do
      pizza = Pizza[params[:id]]
      pizza.update(topping: params[:topping])
      present pizza, with: PizzaEntity
    end

    desc 'Delete a pizza by ID'
    params do
      requires :id, type: Integer, desc: 'Pizza ID'
    end
    delete ':id' do
      pizza = Pizza[params[:id]]
      pizza.destroy
    end

    def consumption_streaks
      Pizza.calculate_increasing_streaks
    end

    def most_pizzas_day
      Pizza.calculate_most_pizzas_day
    end
  end
end
