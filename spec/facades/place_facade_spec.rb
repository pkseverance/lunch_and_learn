require 'rails_helper'

RSpec.describe 'Place Facade' do
    it 'creates place objects out of data from service' do
      json = File.read('spec/fixtures/places_service_response.json')
      params = "apiKey=#{ENV['places_api_key']}&categories=tourism.attraction&filter=circle:139.75,35.68,1000"

      stub_request(:get, "https://api.geoapify.com/v2/places?#{params}")
        .to_return(status: 200, body: json, headers: {})
    
    response = PlacesService.get_places_by_coords([35.68,139.75])

    places = PlaceFacade.tourism_near_coords([35.68,139.75])
    expect(places.count).to eq(response[:features].count)

    expect(places.first).to be_a(Place)
    expect(places.last).to be_a(Place)
  end
end
