class CountriesFacade
  def self.return_random_country
    data = CountryService.all_countries
    
    country_name = data.map { |info| Country.new(info) } 
    country_name.sample
  end

  def self.country_exists?(country)
    data = CountryService.validate_name(country)

    data.map { |info| Country.new(info) }.first.common_name if data.present? #mapping a helper method
  end

  # def create_country_object(data)
  # data.map { |info| Country.new(info) }
  # end

end