class PlacesFacade 

  def self.tourist_sights(info)
    response = PlaceService.capital_city_sights(info)
      # require 'pry';binding.pry
      
      response[:features].map do |data|
        # require 'pry';binding.pry
        TouristSight.new(data)
      end
  end
end