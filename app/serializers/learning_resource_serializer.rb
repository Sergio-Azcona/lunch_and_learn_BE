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
                        
                          "video": video.to_h
                          # {
                          #       "title": video.title,
                          #       "youtube_video_id": video.youtube_video_id
                          # }
                        
                      
    #                       "images": photos.to_json
                        }
            }
    }
  end
end