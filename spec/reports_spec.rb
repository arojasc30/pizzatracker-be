require 'spec_helper'
require 'rack/test'
require 'json'
require 'sequel'
require_relative '../models/pizza'


RSpec.describe 'Pizza API', type: :api do
  include Rack::Test::Methods

  before(:all) do
    # Establish the database connection before running the tests
    DB = Sequel.connect(ENV['DATABASE_URL'])  # Update with your database connection details
  end

  after(:all) do
    # Close the database connection after running the tests
    DB.disconnect
  end

  def app
    PizzaAPI
  end

  describe 'GET /consumption_streaks' do
    it 'returns the streaks of increasing pizza consumption' do
      # Mocking the behavior of the database query
      pizzas = [
        instance_double(Pizza, topping: 'pepperoni', date: Date.new(2023, 5, 16), person_id: 1),
        instance_double(Pizza, topping: 'pepperoni', date: Date.new(2023, 5, 17), person_id: 1),
        instance_double(Pizza, topping: 'pepperoni', date: Date.new(2023, 5, 17), person_id: 1),
        instance_double(Pizza, topping: 'pepperoni', date: Date.new(2023, 5, 18), person_id: 1)
      ]
      allow(Pizza).to receive(:order).with(:date).and_return(pizzas)

      streaks = Pizza.calculate_increasing_streaks

      expect(streaks).to eq([
        { start_date: Date.new(2023, 5, 16), end_date: Date.new(2023, 5, 17) }
      ])
    end
  end

  describe 'GET /most_pizzas_day' do
    it 'returns the day with the most pizzas consumed' do
      # Mocking the behavior of the database query
      pizzas = [
        instance_double(Pizza, topping: 'pepperoni', date: Date.new(2023, 4, 16), person_id: 1),
        instance_double(Pizza, topping: 'pepperoni', date: Date.new(2023, 4, 17), person_id: 1),
        instance_double(Pizza, topping: 'pepperoni', date: Date.new(2023, 4, 17), person_id: 1),
        instance_double(Pizza, topping: 'pepperoni', date: Date.new(2023, 5, 18), person_id: 1)
      ]
      allow(Pizza).to receive(:all).and_return(pizzas)

      most_pizzas_day = Pizza.calculate_most_pizzas_day

      expect(most_pizzas_day).to eq(Date.new(2023, 5, 18))
    end
  end
end
