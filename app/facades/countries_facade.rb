class CountriesFacade
  def self.return_random_country
    data = CountryService.all_countries
    country_name = data.map { |info| Country.new(info) } 
    # require 'pry';binding.pry
    #if random coutry not found, make CountryService call again
    if country_name.present? 
      country_name.sample.common_name
    else
      return_random_country
    end
  end

  def self.country_exists?(country)    
    data = CountryService.validate_name(country)
    data.map { |info| Country.new(info) }.first.common_name if data.present? #mapping a helper method
  end


  def self.validate_input?(country)
    # require 'pry';binding.pry
    if country.present? 
      self.country_exists?(country)
    else
      self.return_random_country 
    end
  end


  def self.capital_city_coordinates(country)
    response = CountryService.validate_name(country)
      # Country.capital_city_info(response)
      response.map { |info| Country.new(info) }
  end
end