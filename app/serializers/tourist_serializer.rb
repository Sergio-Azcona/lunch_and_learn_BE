class TouristSerializer

  def self.capital_city_sights(sights)
    # require 'pry';binding.pry
    {
      "data": sights.map do |sight|
            {
            "id": "null",
            "type": "tourist_sight",#sight.class.to_s.downcase,
            "attributes": 
                        {
                        "name": sight.name,
                        "address": sight.address,
                        "place_id": sight.place_id
                          }
  
            }
          end
      }
  end

end