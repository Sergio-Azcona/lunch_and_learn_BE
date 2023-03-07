class Api::V1::TouristSightsController < ApplicationController

  def index
    country = params[:country]
    capital_city_info = CountriesFacade.capital_city_coordinates(country)
    sights = PlacesFacade.tourist_sights(capital_city_info)
    render json: TouristSerializer.capital_city_sights(sights)  
  end
end