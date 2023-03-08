class Api::V1::FavoritesController < ApplicationController
  def create
    if user = User.find_by(api_key: params[:api_key])
      favorite = user.favorites.new(favorite_params)
      favorite.save
      render json: {
        'success': 'Favorite added successfully'
      }, status: 201
    else
      render json: {
        'failure': 'Failed to find user'
      }, status: 404
    end
  end

  private

  def favorite_params
    params.require(:favorite).permit(:country, :recipe_link, :recipe_title)
  end
end