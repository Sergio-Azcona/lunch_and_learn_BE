class VideosFacade
  def self.youtube_search(country) 
    videos = VideoService.mr_history_search(country)
    
    @country_video = videos[:items].select do |video|
      video[:snippet][:title].include?(country)
    end

  #  return 
   valid_video #if @country_video.nil? return {} 
# require 'pry';binding.pry    

  end
end

  def valid_video 
   if @country_video.nil?
      {}
   else
       @country_video.map { |vid| Video.new(vid) }.first
    end

  end