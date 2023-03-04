class API::V1::RecipesController < ApplicationController
  def index
    recipies = RecipesService.recipe_index_by_country(country)
    require 'pry';binding.pry
  end
end