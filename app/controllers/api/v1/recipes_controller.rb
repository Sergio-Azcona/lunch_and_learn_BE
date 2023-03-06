class Api::V1::RecipesController < ApplicationController
  def index
    country = params[:country]

  # require 'pry';binding.pry
  #   if country.nil?
  #     country = CountryService.return_random_country
  #     recipies = RecipesFacade.country_search(country)
  #     render json: RecipeSerializer.recipies_index_response(country, recipies)
  #   else #country param  exists
  #     CountryService.country_exist?(country)
  #     if country.exists? #country DOES exist
  #       recipies = RecipesFacade.country_search(country)
  #         unless recipies.nil?
  #           render json: RecipeSerializer.recipies_index_response(country, recipies)
  #         else
  #           render json: RecipeSerializer.no_recipes_found
  #         end
  #     else #country does NOT exist
  #       render json: RecipeSerializer.recipies_index_response(country, recipies)
  #     end
  #   end
  # end

    if country.present? 
      valid_country = CountriesFacade.country_exists?(country)
    else
      valid_country = CountriesFacade.return_random_country
    end
    # require 'pry';binding.pry

    recipies = RecipesFacade.country_search(valid_country) if valid_country.present?
    
    if country && recipies
      render json: RecipeSerializer.recipies_index_response(valid_country, recipies)
    else
      render json: RecipeSerializer.no_recipes_found
    end
  end
end