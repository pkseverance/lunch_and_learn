require 'rails_helper'

RSpec.describe 'Places Service' do
  describe '#get_places_by_coords' do
    it 'returns a json response object containing data on local tourist attractions based on coordinate input' do
      json = File.read('spec/fixtures/places_service_response.json')
      params = "apiKey=#{ENV['places_api_key']}&categories=tourism.attraction&filter=circle:139.75,35.68,1000"

      stub_request(:get, "https://api.geoapify.com/v2/places?#{params}")
        .to_return(status: 200, body: json, headers: {})

      results = PlacesService.get_places_by_coords([35.68,139.75])
      expect(results).to be_a(Hash)

      expect(results).to have_key(:features)
      expect(results[:features]).to be_an(Array)

      results[:features].each do |feature|
        expect(feature).to have_key(:properties)
        expect(feature[:properties]).to be_a(Hash)

        if feature[:properties][:name]
          expect(feature[:properties][:name]).to be_a(String)
        end

        expect(feature[:properties]).to have_key(:formatted)
        expect(feature[:properties][:formatted]).to be_a(String)

        expect(feature[:properties]).to have_key(:place_id)
        expect(feature[:properties][:place_id]).to be_a(String)
      end
    end
  end  
end
