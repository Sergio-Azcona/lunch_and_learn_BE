class Api::V1::FavoritesController < ApplicationController  
  def create
    begin
      user = User.find_by(api_key: params[:api_key])
      user.favorites.create!(favorite_params)
      render json: FavoriteSerializer.show_serialize, status: 201
    rescue => error
      render json: ErrorSerializer.serialized_response(error, 404), status: 404
    end
  end

  private

  def favorite_params
    params.require(:favorite).permit(:country, :recipe_link, :recipe_title)
  end
end