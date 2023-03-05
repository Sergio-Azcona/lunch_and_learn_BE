require 'rails_helper'

RSpec.describe 'Recipes Service' do
  describe 'return an index of recipes for a given country' do
    it 'responds with expected keys and datatypes' do
      country = 'thailand'
      json_response = File.read('spec/fixtures/recipes_index_for_thailand.json')
      stub_request(:get, 'https://api.edamam.com/api/recipes/v2?')
        .with(query: {'app_id' => ENV['app_id'], 'app_key' => ENV['app_key'],'type' => 'public', 'q'=> country })
        .to_return(status: 200, body: json_response)

      response =  JSON.parse(json_response, symbolize_names: true)

      expect(response).to be_an(Hash)
      expect(response).to have_key(:hits)
      expect(response[:hits]).to be_an(Array)

      response[:hits].each do |recipes|
        expect(recipes).to be_an(Hash)
        expect(recipes).to have_key(:recipe)
        
        expect(recipes[:recipe]).to have_key(:label)
        expect(recipes[:recipe][:label]).to be_a(String)
        expect(recipes[:recipe]).to have_key(:image)
        expect(recipes[:recipe][:image]).to be_a(String)
        expect(recipes[:recipe]).to have_key(:url)
        expect(recipes[:recipe][:url]).to be_a(String)
      end
    end
  end
end