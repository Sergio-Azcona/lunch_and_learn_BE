class Api::V1::LearningResourcesController < ApplicationController

  def index
    country = params[:country]

    valid_country = CountriesFacade.validate_input?(country) if country.present?
    
    if valid_country.present?
      video = VideosFacade.specific_country_video(valid_country) 
      photos = PhotosFacade.image_search(valid_country) 
    else
      valid_country = country 
    end
    render json: LearningResourceSerializer.country_show_response(valid_country, video, photos)
  end
end