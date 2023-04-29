class LearningResourceSerializer

  def self.country_show_response(country, video, photos)
    # require 'pry';binding.pry
    {
      "data": 
            {
            "id": "null",
            "type": "learning_resources",
            "attributes":  
                        {
                        "country": country,
                          "video": video,#.to_h# unless video.present?
                          "images": photos
                        }
            }
    }
  end
end