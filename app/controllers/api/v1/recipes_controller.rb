class Api::V1::RecipesController < ApplicationController
  def index
    if (params[:country])
      response = RecipeFacade.search_recipes(params[:country])
    else 
      response = RecipeFacade.search_recipes(CountryFacade.random_country_name)
    end

    render json: RecipeSerializer.new(response)
  end
end