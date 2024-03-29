class RecipeSerializer

  def self.recipies_index_response(country, recipies)
    # require 'pry';binding.pry
    {
      "data": 
            recipies.map do |recipe|
              {
                "id": "null",
                "type": recipe.class.to_s.downcase,
                "attributes": 
                            {
                            "title": recipe.title,
                            "url": recipe.url,
                            "country": country,
                            "image": recipe.image
                }
              }
            end
    }
  end  

  def self.no_recipes_found
    {
      "data": []
    }
  end

  def self.country_error(country)
    {
        "errors":
        [ 
          {
          "error_message":  "#{country} does not exist",
          } 
        ]
    }
  end
end