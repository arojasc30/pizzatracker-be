require 'grape-entity'

class PersonEntity < Grape::Entity
  expose :id
  expose :name
end

class PizzaEntity < Grape::Entity
  expose :id
  expose :topping
  expose :person_id
  expose :date
end
