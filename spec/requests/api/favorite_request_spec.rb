require 'rails_helper'

RSpec.describe 'Favorite Request' do
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