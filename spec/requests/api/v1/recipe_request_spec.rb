require 'rails_helper'

RSpec.describe 'Recipe Request' do
  describe 'recipe search' do
    it 'returns a list of recipes based on search params' do
      json = File.read('spec/fixtures/recipe_service_response.json')
      params = "app_id=#{ENV['edamam_search_api_id']}&app_key=#{ENV['edamam_search_api_key']}&type=public&q=thailand"

      stub_request(:get, "https://api.edamam.com/api/recipes/v2?#{params}")
        .to_return(status: 200, body: json, headers: {})

      get '/api/v1/recipes?country=thailand'
      expect(response).to(be_successful)
      
      recipes = JSON.parse(response.body, symbolize_names: true)
      recipes[:data].each do |recipe|
        expect(recipe).to have_key(:id)
        expect(recipe[:id]).to eq(nil)

        expect(recipe[:attributes]).to have_key(:title)
        expect(recipe[:attributes][:title]).to be_a(String)

        expect(recipe[:attributes]).to have_key(:url)
        expect(recipe[:attributes][:url]).to be_a(String)
        
        expect(recipe[:attributes]).to have_key(:country)
        expect(recipe[:attributes][:country]).to be_a(String)

        expect(recipe[:attributes]).to have_key(:image)
        expect(recipe[:attributes][:image]).to be_a(String)
      end
    end
  end
end
