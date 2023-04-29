class VideosFacade
  def self.specific_country_video(country)     
    @country_video = youtube_search(country)

    valid_video unless @country_video.nil?

  end

  def self.valid_video 
    @country_video.map do |vid| 
      Video.new(vid) 
    end.first
  end

  def self.youtube_search(country)
    videos = VideoService.mr_history_search(country)
    
    if videos[:error]
      nil
    else
      videos[:items].select do |video|
        video[:snippet][:title].include?(country)
      end
    end
  end
end