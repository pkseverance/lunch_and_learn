class Api::V1::RecipesController < ApplicationController
  def search
    response = RecipeFacade.search_recipes(params[:country])
    render json: RecipeSerializer.new(response)
  end
end