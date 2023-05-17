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
  end
end
