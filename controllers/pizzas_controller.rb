class PizzasController < Grape::API
  resource :pizzas do
    desc 'Return all pizzas'
    get do
      Pizza.all
    end

    desc 'Return a pizza by ID'
    params do
      requires :id, type: Integer, desc: 'Pizza ID'
    end
    route_param :id do
      get do
        Pizza[params[:id]]
      end
    end

    desc 'Create a new pizza'
    params do
      requires :topping, type: String, desc: 'Pizza topping'
    end
    post do
      Pizza.create(topping: params[:topping])
    end

    desc 'Update a pizza by ID'
    params do
      requires :id, type: Integer, desc: 'Pizza ID'
      requires :topping, type: String, desc: 'Pizza topping'
    end
    put ':id' do
      pizza = Pizza[params[:id]]
      pizza.update(topping: params[:topping])
      pizza
    end

    desc 'Delete a pizza by ID'
    params do
      requires :id, type: Integer, desc: 'Pizza ID'
    end
    delete ':id' do
      pizza = Pizza[params[:id]]
      pizza.destroy
    end
  end
end
