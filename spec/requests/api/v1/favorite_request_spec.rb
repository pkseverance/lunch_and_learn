require 'rails_helper'

RSpec.describe 'Favorite Request' do
  describe 'favorite create' do
    it 'takes in a POST request with JSON body and adds a recipe as a favorite for a specified user' do
      user = User.create!(name: "Paris", email: "paris@meow.net")
      json = {
        api_key: "#{user.api_key}",
        country: "thailand",
        recipe_link: "https://www.tastingtable.com/.....",
        recipe_title: "Crab Fried Rice (Khaao Pad Bpu)"
      }

      headers = { 
      "Content-Type": "application/json", 
      "Accept": "application/json" 
      } 

      post '/api/v1/favorites', headers: headers, params: JSON.generate(json)
      expect(response).to(be_successful)
      expect(response.status).to eq(201)

      data = JSON.parse(response.body, symbolize_names: true)
      favorite = user.favorites.last

      expect(favorite.country).to eq(json[:country])
      expect(favorite.recipe_link).to eq(json[:recipe_link])
      expect(favorite.recipe_title).to eq(json[:recipe_title])

      expect(data).to be_a(Hash)
      expect(data).to have_key(:success)
      expect(data[:success]).to eq("Favorite added successfully")

      json = {
        api_key: "",
        country: "thailand",
        recipe_link: "https://www.tastingtable.com/.....",
        recipe_title: "Crab Fried Rice (Khaao Pad Bpu)"
      }

      headers = { 
      "Content-Type": "application/json", 
      "Accept": "application/json" 
      } 

      post '/api/v1/favorites', headers: headers, params: JSON.generate(json)
      expect(response).to_not(be_successful)
      expect(response.status).to eq(404)
    end
  end

  describe 'favorite index' do
    it 'returns a list of favorites for a specific user' do
      user = User.create!(name: "Paris", email: "paris@meow.net")
      favorite1 = user.favorites.create(country: 'United States', recipe_link: 'freedomrecipes.com/cheeseburger', recipe_title: 'Cheese Burger')
      favorite2 = user.favorites.create(country: 'United Kingdom', recipe_link: 'bigbenrecipes.com/fish_and_chips', recipe_title: 'Fish and Chips')

      get "/api/v1/favorites?api_key=#{user.api_key}"
      expect(response).to(be_successful)
      data = JSON.parse(response.body, symbolize_names: true)

      expect(data).to be_a(Hash)
      expect(data).to have_key(:data)
      expect(data[:data]).to be_a(Array)
      expect(data[:data].count).to eq(user.favorites.count)

      data[:data].each do |favorite|
        expect(favorite).to be_a(Hash)
        expect(favorite).to have_key(:id)
        expect(favorite[:id]).to be_a(String)
        expect(favorite).to have_key(:type)
        expect(favorite[:type]).to eq('favorite')
        expect(favorite).to have_key(:attributes)
        expect(favorite[:attributes]).to be_a(Hash)
        expect(favorite[:attributes]).to have_key(:country)
        expect(favorite[:attributes][:country]).to be_a(String)
        expect(favorite[:attributes]).to have_key(:recipe_link)
        expect(favorite[:attributes][:recipe_link]).to be_a(String)
        expect(favorite[:attributes]).to have_key(:recipe_title)
        expect(favorite[:attributes][:recipe_title]).to be_a(String)
        expect(favorite[:attributes]).to have_key(:created_at)
        expect(favorite[:attributes][:created_at]).to be_a(String)
      end

      user2 = User.create!(name: "Lua", email: "Lua@moon.net")
      get "/api/v1/favorites?api_key=#{user2.api_key}"
      expect(response).to(be_successful)
      data = JSON.parse(response.body, symbolize_names: true)
      expect(data).to be_a(Hash)
      expect(data).to have_key(:data)
      expect(data[:data]).to be_a(Array)
      expect(data[:data].count).to eq(0)

      get "/api/v1/favorites?api_key="
      expect(response).to_not(be_successful)
      expect(response.status).to eq(401)
    end
  end
end