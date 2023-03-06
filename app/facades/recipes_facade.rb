class RecipesFacade 

  def self.country_search(country)
    response = RecipesService.recipe_index_by_country(country)
    
    response[:hits].map do |recipe_data|
      Recipe.new(recipe_data)
    end
  end
end