class CountryService
  def self.search_by_full_name(country)
    JSON.parse(Faraday.new("https://restcountries.com/v3.1/name/#{country}?fullText=true"))
  end
end