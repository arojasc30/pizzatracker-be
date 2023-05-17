class PeopleController < Grape::API
  resource :people do
    desc 'Return all people'
    get do
      Person.all
    end

    desc 'Return a person by ID'
    params do
      requires :id, type: Integer, desc: 'Person ID'
    end
    route_param :id do
      get do
        Person[params[:id]]
      end
    end

    desc 'Create a new person'
    params do
      requires :name, type: String, desc: 'Person name'
    end
    post do
      Person.create(name: params[:name])
    end

    desc 'Update a person by ID'
    params do
      requires :id, type: Integer, desc: 'Person ID'
      requires :name, type: String, desc: 'Person name'
    end
    put ':id' do
      person = Person[params[:id]]
      person.update(name: params[:name])
      person
    end

    desc 'Delete a person by ID'
    params do
      requires :id, type: Integer, desc: 'Person ID'
    end
    delete ':id' do
      person = Person[params[:id]]
      person.destroy
    end
  end
end
