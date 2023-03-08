class Api::V1::FavoritesController < ApplicationController
  def index
    if user = User.find_by(api_key: params[:api_key])
      favorites = user.favorites
      render json: FavoriteSerializer.new(favorites)
    elsif params[:api_key] == 'coffee' # This should never happen
      render json: {
        'failure': 'I am a teapot'
      }, status: 418
    else
      render json: {
        'failure': 'Invalid API Key'
      }, status: 401
    end
  end

  def create
    if user = User.find_by(api_key: params[:api_key])
      favorite = user.favorites.new(favorite_params)
      favorite.save
      render json: {
        'success': 'Favorite added successfully'
      }, status: 201
    elsif params[:api_key] == 'coffee' # This should never happen
      render json: {
        'failure': 'I am a teapot'
      }, status: 418
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