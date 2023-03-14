class Api::V1::LearningResourcesController < ApplicationController

  def index
    country = params[:country]

    valid_country = CountriesFacade.validate_input?(country) if country.present?
    
    if valid_country.present?
      video = VideosFacade.youtube_search(valid_country) 
      photos = PhotosFacade.image_search(valid_country) 
    else
      #if not a valid country, reset 'valid_country'to the INPUT to return to FE so they can see what they searched
      valid_country = country 
    end
# require 'pry';binding.pry
    render json: LearningResourceSerializer.country_show_response(valid_country, video, photos)
  end
end