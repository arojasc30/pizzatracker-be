Sequel.migration do
  change do
    create_table(:people) do
      primary_key :id
      String :name
    end

    create_table(:pizzas) do
      primary_key :id
      String :topping
      DateTime :date
      foreign_key :person_id, :people
    end
  end
end
