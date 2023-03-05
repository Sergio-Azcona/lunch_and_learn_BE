class Api::V1::RecipesController < ApplicationController
  def index
    country = params[:country]





# require 'pry';binding.pry
    if country.nil?
      country = CountryService.return_random_country
      recipies = RecipesFacade.country_search(country)
      render json: RecipeSerializer.recipies_index_response(country, recipies)
    else #country param  exists
      CountryService.validate_existence(country)
      if country.exists? #country DOES exist
        recipies = RecipesFacade.country_search(country)
          unless recipies.nil?
            render json: RecipeSerializer.recipies_index_response(country, recipies)
          else
            render json: RecipeSerializer.no_recipes_found
          end
      else #country does NOT exist
        render json: RecipeSerializer.recipies_index_response(country, recipies)
      end
    end

  end

 
  unless country 
    country = CountryService.return_random_country
  else
    CountryService.validate_existence(country)
    require 'pry';binding.pry
    
  end


  recipies = RecipesFacade.country_search(country)

  if country && recipies
    render json: RecipeSerializer.recipies_index_response(country, recipies)
  else
    render json: RecipeSerializer.no_recipes_found
  end

end