class ConsumptionsController < Grape::API
  resource :consumptions do
    desc 'Record the consumption of a pizza by a person'
    params do
      requires :person_id, type: Integer, desc: 'Person ID'
      requires :pizza_id, type: Integer, desc: 'Pizza ID'
    end
    post do
      person = Person[params[:person_id]]
      pizza = Pizza[params[:pizza_id]]
      Consumption.create(person: person, pizza: pizza)
    end

    desc 'Get all pizza consumptions'
    get do
      Consumption.all
    end

    desc 'Get streaks of increasing pizza consumption'
    get 'streaks' do
      Consumption.calculate_increasing_streaks
    end

    desc 'Get the day of the month with the most pizzas eaten'
    get 'most_pizzas_day' do
      Consumption.calculate_most_pizzas_day
    end
  end
end
