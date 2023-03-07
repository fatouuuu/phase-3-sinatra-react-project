# Pet.destroy_all
# User.destroy_all
puts "🌱 Seeding spices..."

# Create Users
# user1 = User.create!(username: 'john_doe', password: 'password')
user1 = User.create(username: 'john_doe', email: 'john_doe@example.com', password: 'password')
user2 = User.create(username: 'jane_doe', email: 'jane_doe@example.com', password: 'password')
user3 = User.create(username: 'bob_smith', email: 'bob_smith@example.com', password: 'password')
user3 = User.create(username: 'alice_smith', email: 'alice_smith@example.com', password: 'password')
user4 = User.create(username: 'tom_jones', email: 'tom_jones@example.com', password: 'password')
user5 = User.create(username: 'sarah_jones', email: 'sarah_jones@example.com', password: 'password')



# # Create Pets
# Pet.create(breed_name: "Monkey Terrier", breed: "Affenpinscher", color: "Golden", breed_for: "Hunting", sex: "Male", lifespan: "10-12 years", temperament: "Intelligent, Friendly, Devoted", image_url: "https://placedog.net/500", user: user1)
# Pet.create(breed_name: "Poodle", breed: "Poodle", color: "White", breed_for: "Hunting", sex: "Female", lifespan: "12-15 years", temperament: "Active, Proud, Smart", image_url: "https://placedog.net/501", user: user1)
# Pet.create(breed_name: "Siberian Husky", breed: "Husky", color: "Black/White", breed_for: "Sled pulling", sex: "Male", lifespan: "12-15 years", temperament: "Outgoing, Friendly, Alert", image_url: "https://placedog.net/502", user: user2)
# Pet.create(breed_name: "Rottweiler", breed: "Rottweiler", color: "Black/Tan", breed_for: "Cattle driving", sex: "Female", lifespan: "8-10 years", temperament: "Good-natured, Devoted, Alert", image_url: "https://placedog.net/503", user: user2)
# Pet.create(breed_name: "Labrador Retriever", breed: "Retriever", color: "Black", breed_for: "Hunting", sex: "Male", lifespan: "10-14 years", temperament: "Friendly, Active, Outgoing", image_url: "https://placedog.net/504", user: user3)
# Pet.create(breed_name: "German Shepherd", breed: "German Shepherd", color: "Black/Tan", breed_for: "Herding", sex: "Female", lifespan: "9-13 years", temperament: "Loyal, Confident, Courageous", image_url: "https://placedog.net/505", user: user3)
# Pet.create(breed_name: "Bulldog", breed: "Bulldog", color: "White/Brown", breed_for: "Fighting", sex: "Male", lifespan: "8-10 years", temperament: "Friendly, Courageous, Calm", image_url: "https://placedog.net/506", user: user4)
# Pet.create(breed_name: "Boxer", breed: "Boxer", color: "Brindle", breed_for: "Fighting", sex: "Female", lifespan: "9-12 years", temperament: "Friendly, Cheerful, Fearless", image_url: "https://placedog.net/507", user: user4)
# Pet.create(breed_name: "Beagle", breed: "Beagle", color: "Tricolor", breed_for: "Hunting", sex: "Male", lifespan: "12-15 years", temperament: "Friendly, Curious, Merry", image_url: "https://placedog.net/508", user: user5)


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


puts "✅ Done seeding!"
