require 'rails_helper'

RSpec.describe 'Image Service' do
    it 'returns a json response object containing data of videos on the given country' do
      json = File.read('spec/fixtures/image_service_response.json')
      params ="query=china&client_id=#{ENV['unsplash_client_key']}"

      stub_request(:get, "https://api.unsplash.com/search/photos?#{params}")
        .to_return(status: 200, body: json, headers: {})

      results = ImageService.get_images_by_country('china')
      expect(results).to be_a(Hash)

      expect(results).to have_key(:results)
      expect(results[:results]).to be_an(Array)

      results[:results].each do |result|
        expect(result).to be_a(Hash)

        expect(result).to have_key(:description)
        expect(result[:description]).to be_a(String).or(eq(nil))

        expect(result).to have_key(:links)
        expect(result[:links]).to be_a(Hash)

        expect(result[:links]).to have_key(:html)
        expect(result[:links][:html]).to be_a(String) 
      end
    end
end