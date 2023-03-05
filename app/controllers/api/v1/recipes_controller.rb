class Api::V1::RecipesController < ApplicationController
  def index
    country = params[:country]
    recipies = RecipesFacade.country_search(country)
    # require 'pry';binding.pry
    render json: RecipeSerializer.recipies_index_response(country, recipies)
  end
end