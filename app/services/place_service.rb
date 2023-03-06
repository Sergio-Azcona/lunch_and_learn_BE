class PlaceService
  def self.capital_city_sights(info)
    
    lat = info[0].capital_latitude
    long = info[0].capital_longitude
    limit = 20
    meters = 1000
    key = ENV['apiKey']
    category = 'tourism.sights'

    response = Faraday.get("https://api.geoapify.com/v2/places?categories=#{category}&filter=circle:#{long},#{lat},#{meters}&limit=#{limit}&apiKey=#{key}")

    # response = Faraday.new('https://api.geoapify.com/v2/places?') do |f|
    #   f.params['apiKey'] = ENV['apiKey']
    #   f.params['categories'] = 'tourism.sights'
    #   f.params['filter'] = "circle:#{long},#{lat},20000"
    #   f.params['limit'] = '20'
    # end
    # require 'pry';binding.pry
    parse_json(response) 
  end

  def self.parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end