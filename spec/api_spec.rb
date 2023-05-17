require 'rack/test'
require_relative '../app'

describe PizzaAPI do
  include Rack::Test::Methods

  def app
    PizzaAPI
  end

  it 'returns all pizzas' do
    get '/api/pizzas'
    expect(last_response.status).to eq(200)
    expect(JSON.parse(last_response.body)).to be_an_instance_of(Array)
  end

  it 'creates a new pizza' do
    post '/api/pizzas', { topping: 'Pepperoni' }
    expect(last_response.status).to eq(201)
    expect(JSON.parse(last_response.body)).to be_an_instance_of(Hash)
  end

  # Add more test cases for other endpoints
end
