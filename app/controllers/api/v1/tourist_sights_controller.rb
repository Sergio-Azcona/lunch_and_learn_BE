class Api::V1::TouristSightsController < ApplicationController

  def index
    country = params[:country]
    
    capital_city_info = CountriesFacade.capital_city_coordinates(country)
    
    sights = PlacesFacades.tourist_sights(capital_city_info)
    require 'pry';binding.pry
  
  end
end