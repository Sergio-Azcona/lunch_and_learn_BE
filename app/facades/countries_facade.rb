class CountriesFacade
  def self.return_random_country
    data = CountryService.all_countries
    # require 'pry';binding.pry
    country_name = data.map { |info| Country.new(info) } 
    country_name.sample.common_name
  end

  def self.country_exists?(country)    
    data = CountryService.validate_name(country)
    data.map { |info| Country.new(info) }.first.common_name if data.present? #mapping a helper method
  end


  def self.validate_input?(country)
    # require 'pry';binding.pry

    if country ==  ''
      return nil 
    elsif country.nil? 
      self.return_random_country 
    else
      self.country_exists?(country)
    end
  end


  def self.capital_city_coordinates(country)
    response = CountryService.validate_name(country)
      # Country.capital_city_info(response)
      response.map { |info| Country.new(info) }
  end
end