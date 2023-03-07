class CountryService
  def self.validate_name(country)
    response = conn.get("/v3.1/name/#{country}")    
    # require 'pry';binding.pry
    parse_json(response) if response.status == 200
  end

  def self.all_countries
    parse_json(conn.get("/v3.1/all"))
  end

  def self.parse_json(response) 
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new('https://restcountries.com')
  end
end