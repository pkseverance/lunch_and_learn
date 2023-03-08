require 'rails_helper'

RSpec.describe 'User Request' do
  it 'takes in a POST request with JSON body and creates a user in the database' do
    json = {
      name: "Lua",
      email: "realperson@themoon.org"
    }

    headers = { 
    "Content-Type": "application/json", 
    "Accept": "application/json" 
    } 

    post '/api/v1/users', headers: headers, params: JSON.generate(user: json)
    expect(response).to(be_successful)
    expect(response.status).to eq(201)
    data = JSON.parse(response.body, symbolize_names: true)

    expect(User.last.email).to eq(json[:email])
    expect(User.last.name).to eq(json[:name])
    expect(User.last.api_key).to be_a(String)

    expect(data).to be_a(Hash)
    expect(data).to have_key(:data)
    expect(data[:data]).to be_a(Hash)
    expect(data[:data]).to have_key(:id)
    expect(data[:data][:id]).to be_a(String)
    expect(data[:data]).to have_key(:type)
    expect(data[:data][:type]).to eq('user')
    expect(data[:data]).to have_key(:attributes)
    expect(data[:data][:attributes]).to be_a(Hash)
    expect(data[:data][:attributes]).to have_key(:name)
    expect(data[:data][:attributes][:name]).to eq(json[:name])
    expect(data[:data][:attributes]).to have_key(:email)
    expect(data[:data][:attributes][:email]).to eq(json[:email])
    expect(data[:data][:attributes]).to have_key(:api_key)
    expect(data[:data][:attributes][:api_key]).to be_a(String)
  end
end