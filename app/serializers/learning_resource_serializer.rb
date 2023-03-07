class LearningResourceSerializer

  def self.country_show_response(country, video, photos)
    # require 'pry';binding.pry
    {
      "data": {
            "id": "null",
            "type": "learning_resources",
            "attributes":  {
                        "country": country,
                        
                        
                          "video": if  video.present?
                                {
                                        "title": video.title,
                                        "youtube_video_id": video.youtube_video_id
                                }
                              else
                                  {}
                              end,

                        
                          "images": if photos.present?
                                    photos.map do |photo|
                                            {
                                            "alt_tag": photo[:alt_description],
                                            "url": photo[:urls][:raw]
                                      }
                                    end
                                  else
                                    []
                                  end

              }
        }
    }
  end
end