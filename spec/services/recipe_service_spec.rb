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
        end
    end
end