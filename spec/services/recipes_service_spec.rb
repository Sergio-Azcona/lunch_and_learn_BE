require 'rails_helper'

RSpec.describe 'Recipes Service' do
  describe 'return an index of recipes for a given country' do
    it 'returns a successful response with the top level keys requested' do
      country = 'thailand'
      json_response = File.read('spec/fixtures/recipes_index_for_thailand.json')
      stub_request(:get, 'https://api.edamam.com/api/recipes/v2?')
        .with(query: {'app_id' => ENV['app_id'], 'app_key' => ENV['app_key'],'type' => 'public', 'q'=> country })
        .to_return(status: 200, body: json_response)

      response = RecipesService.recipe_index_by_country(country)

      expect(response).to be_an(Hash)
      expect(response).to have_key(:hits)
      expect(response[:hits]).to be_an(Array)

      response[:hits].each do |recipes|
        # require 'pry';binding.pry
        expect(recipes).to be_an(Hash)
        expect(recipes).to have_key(:recipe)
        
        recipes[:recipe].each do |recipe|
          require 'pry';binding.pry
          expect(recipe).to have_key(:uri)
        
      end


      end



    end
  end
end