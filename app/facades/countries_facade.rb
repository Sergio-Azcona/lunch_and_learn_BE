class CountriesFacade
  def self.return_random_country
    data = CountryService.all_countries
    # require 'pry';binding.pry
    country_name = data.map { |info| Country.new(info) } 
    country_name.sample.common_name
    # require 'pry';binding.pry
  end

  def self.country_exists?(country)
    
      return nil if country == ''
    # else
      data = CountryService.validate_name(country)
      data.map { |info| Country.new(info) }.first.common_name if data.present? #mapping a helper method
    # end
  end

  # def create_country_object(data)
  # data.map { |info| Country.new(info) }
  # end

end