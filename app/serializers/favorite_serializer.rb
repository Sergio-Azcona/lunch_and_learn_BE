class FavoriteSerializer
  def self.create_success_serialize
    {
      "success": "Favorite added successfully"
    }
  end

  def self.index_serialize(favorites)
    {
      "data": favorites.map do |favorite|
            {
                "id": favorite.id,
                "type": favorite.class.to_s.downcase,
                "attributes": {
                    "recipe_title": favorite.recipe_title,
                    "recipe_link": favorite.recipe_link,
                    "country": favorite.country,
                    "created_at": favorite.created_at
                  }
              }
          end
      }
  end

end