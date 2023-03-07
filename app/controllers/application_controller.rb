class ApplicationController < Sinatra::Base

  configure do
    set :views, 'app/views'
    set :public_folder, 'public'
  end

  # SIGNUP AND LOGIN AUTHENTICATION
    # @helper: read JSON body
  before do
    begin
      @user = user_data
    rescue
      @user = nil
    end
  end

  #@method: create a new user
  post '/auth/register' do
    begin
      x = User.create(@user)
      json_response(code: 201, data: x)
    rescue => e
      error_response(422, e)
    end
  end

  #@method: log in user using email and password
  post '/auth/login' do
    begin
      user_data = User.find_by(email: @user['email'])
      if user_data.password == @user['password']
        json_response(code: 200, data: {
          id: user_data.id,
          email: user_data.email
        })
      else
        json_response(code: 422, data: { message: "Your email/password combination is not correct" })
      end
    rescue => e
      error_response(422, e)
    end
  end

  private

  # @helper: parse user JSON data
  def user_data
    JSON.parse(request.body.read)
  end


  # CRUD OPERATIONS FOR USERS

  # GET all users
  get '/users' do
    @users = User.all
    # erb :users_index
    @users.to_json
  end

  # GET a single user
  get '/users/:id' do
    @user = User.find(params[:id])
    # erb :users_show
    @user.to_json
  end

  # GET the form for creating a new user
  get '/users/new' do
    # erb :users_new
    @user = User.new
    @user.to_json
  end

  # POST to create a new user
  post '/users' do
    @user = User.new(params)
    if @user.save
      redirect '/users'

    else
      # erb :users_new
      puts 'Unable to crate new user'
    end
  end

  # GET the form for updating a user
  get '/users/:id/edit' do
    @user = User.find(params[:id])
    erb :users_edit
  end

  # PUT to update a user
  put '/users/:id' do
    @user = User.find(params[:id])
    if @user.update(params[:user])
      redirect '/users'
    else
      erb :users_edit
    end
  end

  # DELETE a user
  delete '/users/:id' do
    @user = User.find(params[:id])
    @user.destroy
    redirect '/users'
  end


  # CRUD OPERATIONS FOR PETS 

  # route to create a new pet
  post '/pets' do
    # create a new pet object with parameters from request
    pet = Pet.new(params)
    if pet.save
      # send a response indicating successful creation of a new pet
      status 201
      pet.to_json
    else
      # send an error response if pet creation fails
      status 400
      { error: "Could not create pet" }.to_json
    end
  end
  
  # route to retrieve a list of all pets
  get '/pets' do
    # retrieve all pets from database
    pets = Pet.all
    pets.to_json
  end
  
  # route to retrieve a specific pet by id
  get '/pets/:id' do
    # retrieve a pet with a specific id from database
    pet = Pet.find(params[:id])
    pet.to_json
  end
  
  # route to retrieve a specific pet by breed_name
  get '/pets/breed/:breed_name' do
    # retrieve a pet with a specific breed_name from database
    pet = Pet.find_by(breed_name: params[:breed_name])
    pet.to_json
  end
 

  # route to update a specific pet by id
  put '/pets/:id' do
    # retrieve a pet with a specific id from database
    pet = Pet.find(params[:id])
    if pet.update(params)
      # send a response indicating successful update of the pet
      pet.to_json
    else
      # send an error response if update fails
      status 400
      { error: "Could not update pet" }.to_json
    end
  end
  
  # route to delete a specific pet by id
  delete '/pets/:id' do
    # retrieve a pet with a specific id from database
    pet = Pet.find(params[:id])
    if pet.destroy
      # send a response indicating successful deletion of the pet
      pet.to_json
      puts 'successfully deleted'
    else
      # send an error response if deletion fails
      status 400
      { error: "Could not delete pet" }.to_json
    end
  end
  
  # route to partially update a specific pet by id
  patch '/pets/:id' do
    # retrieve a pet with a specific id from database
    pet = Pet.find(params[:id])
    if pet.update(params)
      # send a response indicating successful partial update of the pet
      pet.to_json
    else
      # send an error response if partial update fails
      status 400
      { error: "Could not partially update pet" }.to_json
    end
  end
end
