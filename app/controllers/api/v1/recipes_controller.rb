class Api::V1::RecipesController < ApplicationController
  def index
    country = params[:country]
    # require 'pry';binding.pry
    valid_country = CountriesFacade.validate_input?(country) unless country == ''
    # require 'pry';binding.pry 
    # if valid_country.present?
      recipies = RecipesFacade.country_search(valid_country) unless valid_country.nil? 
    # end

    if valid_country && recipies.present?
      render json: RecipeSerializer.recipies_index_response(valid_country, recipies)
    elsif
      valid_country && recipies.empty?
      render json: RecipeSerializer.no_recipes_found, status: 404
    else
      # require 'pry';binding.pry
      valid_country.nil?
      render json: RecipeSerializer.country_error(country), status: 404
    end
  end
end