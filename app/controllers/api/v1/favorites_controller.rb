class Api::V1::FavoritesController < ApplicationController  
  
  def index
    begin
      user = User.find_by(api_key: params[:api_key])
      favorites = user.favorites
      render json: FavoriteSerializer.index_serialize(favorites), status: 201
    rescue => error
      render json: ErrorSerializer.serialized_response(error, 404), status: 404
    end
  end
  
  def create
    begin
      user = User.find_by(api_key: params[:api_key])
      user.favorites.create!(favorite_params)
      render json: FavoriteSerializer.create_success_serialize, status: 201
    rescue => error
      render json: ErrorSerializer.serialized_response(error, 404), status: 404
    end
  end

  private

  def favorite_params
    params.require(:favorite).permit(:country, :recipe_link, :recipe_title)
  end
end