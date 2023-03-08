class Api::V1::RecipesController < ApplicationController
  def index
    country = params[:country]
    
    valid_country = CountriesFacade.validate_input?(country) #if country.present?
    # require 'pry';binding.pry

    recipies = RecipesFacade.country_search(valid_country) if valid_country.present?

    if valid_country && recipies.present?
      render json: RecipeSerializer.recipies_index_response(valid_country, recipies)
    else
      render json: RecipeSerializer.no_recipes_found, status: 404
    end
  end
end