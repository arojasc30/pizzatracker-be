class Person < Sequel::Model(DB[:people])
  one_to_many :pizzas
end