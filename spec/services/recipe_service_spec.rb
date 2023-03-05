require 'rails_helper'

RSpec.describe 'Recipe Service' do
    it 'returns a json response object of recipes' do
      response = File.read('spec/fixtures/recipe_service_response.json')
      params = "app_id=#{ENV['edamam_search_api_id']}&app_key=#{ENV['edamam_search_api_key']}&type=public&q=thailand"
      stub_request(:get, "https://api.edamam.com/api/recipes/v2?#{params}")
        .to_return(status: 200, body: response, headers: {})

        results = RecipeService.get_recipe_by_country(params)
        expect(results).to be_a(Hash)
        expect(results).to have_key(:hits)

        results[:hits].map do |result|
          expect(result).to have_key(:recipe)
            expect(result[:recipe]).to have_key(:label)
            expect(result[:recipe][:label]).to be_a(String)

            expect(result[:recipe]).to have_key(:image)
            expect(result[:recipe][:image]).to be_a(String)

            expect(result[:recipe]).to have_key(:url)
            expect(result[:recipe][:url]).to be_a(String)
        end
    end
end