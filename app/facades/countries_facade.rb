class CountryFacade
  def self.return_random_country
    data = CountryService.all_countries
    country_name = data.map { |info| Country.new(info) } 
    country_name.sample
  end

  def self.country_exists?(country)
    data = CountryService.validate_name(country)

    if country[:status] == '404'
      country == nil
    else
      country = data.map { |info| Country.new(info) } #mapping a helper method
    end

  end

end