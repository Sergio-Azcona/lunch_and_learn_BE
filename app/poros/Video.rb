class Video
  attr_reader :title, :youtube_video_id
  def initialize(data)
    @title = data[:snippet][:title].to_json
    @youtube_video_id = data[:id][:videoId].to_json
  end
end