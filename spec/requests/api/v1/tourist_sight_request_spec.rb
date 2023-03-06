require 'rails_helper'

RSpec.describe 'Tourist Sight Request' do
  it 'returns json response object containing data on tourist sights near capital of given country' do

    json_1 = File.read('spec/fixtures/country_service_get_country_response.json')

      stub_request(:get, 'https://restcountries.com/v3.1/name/japan')
        .to_return(status: 200, body: json_1, headers: {})

    json_2 = File.read('spec/fixtures/places_service_response.json')
      params = "apiKey=#{ENV['places_api_key']}&categories=tourism.attraction&filter=circle:139.75,35.68,1000"

      stub_request(:get, "https://api.geoapify.com/v2/places?#{params}")
        .to_return(status: 200, body: json_2, headers: {})

    get '/api/v1/tourist_sights?country=japan'
    expect(response).to(be_successful)

    places = JSON.parse(response.body, symbolize_names: true)
    expect(places).to be_a(Hash)
    
    places[:data].each do |place|
      expect(place).to have_key(:id)
      expect(place[:id]).to eq(nil)

      expect(place).to have_key(:type)
      expect(place[:type]).to eq('tourist_sight')

      expect(place).to have_key(:attributes)
      expect(place[:attributes]).to be_a(Hash)

      expect(place[:attributes]).to have_key(:name)
      expect(place[:attributes][:name]).to be_a(String).or(eq(nil))

      expect(place[:attributes]).to have_key(:address)
      expect(place[:attributes][:address]).to be_a(String)

      expect(place[:attributes]).to have_key(:place_id)
      expect(place[:attributes][:place_id]).to be_a(String)
    end
  end
end