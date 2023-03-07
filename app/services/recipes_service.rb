class RecipesService
  def self.recipe_index_by_country(country)
    response = conn.get('/api/recipes/v2?') do |search|
      search.params['q'] = country 
    end
    parse_json(response) if response.status == 200
  end

  def self.parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new('https://api.edamam.com') do |f|
      f.params['app_id'] = ENV['app_id']
      f.params['app_key'] = ENV['app_key']
      f.params['type'] = 'public'
    end
  end
end