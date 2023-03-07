class VideoService

  def self.mr_history_search(country)
    response = conn.get('/youtube/v3/search?') do |search|
      search.params['channelId'] = 'UCluQ5yInbeAkkeCndNnUhpw'
      search.params['type'] = 'video'
      search.params['q'] = country
    end
    parse_json(response)
  end


  def self.conn 
    Faraday.new('https://www.googleapis.com') do |f|
      f.params['key'] = ENV['key']
      f.params['part'] = 'snippet'

    end
  end
    
  def self.parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end