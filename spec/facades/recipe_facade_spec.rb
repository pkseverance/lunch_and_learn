require 'rails_helper'

RSpec.describe 'RecipeFacade' do
  describe '#search_recipes' do
    it 'returns recipe poros containing data from a JSON response object' do
      json = File.read('spec/fixtures/recipe_service_response.json')
      params = "app_id=#{ENV['edamam_search_api_id']}&app_key=#{ENV['edamam_search_api_key']}&type=public&q=thailand"

      stub_request(:get, "https://api.edamam.com/api/recipes/v2?#{params}")
        .to_return(status: 200, body: json, headers: {})

      response = RecipeService.get_recipe_by_country('thailand')
      recipes = RecipeFacade.search_recipes('thailand')
      expect(recipes).to be_an(Array)
      expect(recipes.count).to eq(response[:hits].count)
      recipes.each do |recipe|
        expect(recipe).to be_a(Recipe)
      end
    end
  end
end