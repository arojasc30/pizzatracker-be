require 'csv'
require 'sequel'

DB = Sequel.connect(adapter: :postgres, database: 'pizza-api')

require_relative 'models/person'
require_relative 'models/pizza'

csv_path = ARGV[0]

# Validate the CSV path
unless File.exist?(csv_path) && File.file?(csv_path)
  puts "Invalid CSV file path: #{csv_path}"
  exit
end

CSV.foreach(csv_path, headers: true) do |row|
  person_name = row['person']
  meat_type = row['meat-type']
  date = row['date']

  # Check if a person with the same name already exists in the database
  person = Person.first(name: person_name)

  unless person
    # If the person doesn't exist, create a new record
    person = Person.create(name: person_name)
  end

  # Create a pizza record using the person's ID and the other data from the CSV
  Pizza.create(topping: meat_type, date: date, person_id: person.id)
end

puts 'Database seeding completed.'
