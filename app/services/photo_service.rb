class PhotoService
  def self.unsplash_search(valid_country)
    response = unsplash_conn.get('/search/photos?') do |search|
      search.params['page'] = 1
      search.params['per_page'] = 100
      search.params['query'] = valid_country
    end
    parse_json(response)
  end


  def self.unsplash_conn
    Faraday.new('https://api.unsplash.com') do |f|
      f.params[:client_id] = "#{ ENV['access_key'] }"
    end
  end

  def self.parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end