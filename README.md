# Pizza Tracker API

## Installation

1. Run bundle install:

   ```shell
   npm install

2. Create Postgresql database

  ```shell
  createdb pizza-api

2. Run migrations:

   ```shell
   bundle exec sequel -m migrations postgres://localhost/pizza-api

3. Seed database:

   ```shell
   ruby seed.rb path/to/csv/file.csv

4. Run server:

   ```shell
   bundle exec rackup