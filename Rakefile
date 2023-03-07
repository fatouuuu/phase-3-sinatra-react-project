require_relative "./config/environment"
require "sinatra/activerecord/rake"

desc "Start the server"
task :server do  
  if ActiveRecord::Base.connection.migration_context.needs_migration?
    puts "Migrations are pending. Make sure to run `rake db:migrate` first."
    return
  end

  # rackup -p PORT will run on the port specified (9292 by default)
  ENV["PORT"] ||= "9292"
  rackup = "rackup -p #{ENV['PORT']}"

  # rerun allows auto-reloading of server when files are updated
  # -b runs in the background (include it or binding.pry won't work)
  exec "bundle exec rerun -b '#{rackup}'"
end

desc "Start the console"
task :console do
  ActiveRecord::Base.logger = Logger.new(STDOUT)
  Pry.start
end

desc "Seed the database"
task :seed do
  # Insert data into the database using your model classes
  require 'rest-client'
require 'json'
require 'faker'

# Define the API endpoint and fetch the data
url = 'https://api.thedogapi.com/v1/breeds'
response = RestClient.get(url)
data = JSON.parse(response.body)

# Generate 20 random pets
50.times do
  # Select a random breed from the data
  breed = data.sample

  # Create a pet with random attributes using faker and data from the external api
  Pet.create(
    breed_name: breed['name'],
    breed: breed['breed_group'],
    color: Faker::Color.unique.color_name,
    breed_for: breed['bred_for'],
    sex: Faker::Gender.binary_type,
    lifespan: breed['life_span'],
    temperament: breed['temperament'],
    image_url: breed['image']['url'],
    user_id: rand(1..10) # Assuming there are 10 users in the system
  )
end


# puts "✅ Done seeding!"

end
