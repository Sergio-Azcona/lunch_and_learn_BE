require 'rails_helper'

RSpec.describe 'Recipes Service' do
  describe 'successful requests - return an index of recipes for a given country' do
    it 'responds with expected keys and datatypes' do
      country = 'thailand'
      json_response = File.read('spec/fixtures/service_responses/recipes/recipes_index_for_thailand.json')
      stub_request(:get, 'https://api.edamam.com/api/recipes/v2?')
        .with(query: {'app_id' => ENV['app_id'], 'app_key' => ENV['app_key'],'type' => 'public', 'q'=> country })
        .to_return(status: 200, body: json_response)

      response =  JSON.parse(json_response, symbolize_names: true)

      expect(response).to be_an(Hash)
      expect(response).to have_key(:hits)
      expect(response[:hits]).to be_an(Array)
      expect(response[:hits].present?).to eq(true)  

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

    it 'responds with no recipes' do
      country = 'thailand'
      json_response = File.read('spec/fixtures/service_responses/recipes/recipes_empty_service_response.json')
      stub_request(:get, 'https://api.edamam.com/api/recipes/v2?')
        .with(query: {'app_id' => ENV['app_id'], 'app_key' => ENV['app_key'],'type' => 'public', 'q'=> country })
        .to_return(status: 200, body: json_response)

      response =  JSON.parse(json_response, symbolize_names: true)
  
      expect(response).to be_an(Hash)
      expect(response).to have_key(:hits)
      expect(response[:hits]).to be_an(Array)

      expect(response[:hits].present?).to eq(false)    
      expect(response[:hits]).to eq([])
    end
  end

  describe 'unsuccessful requests-incomplete api info is submitted' do
    it 'errors if api_key is missing' do
      country = 'thailand'
      json_response = File.read('spec/fixtures/service_responses/recipes/error_no_api_key.json')
      stub_request(:get, 'https://api.edamam.com/api/recipes/v2?')
        .with(query: {'app_id' => ENV['app_id'], 'type' => 'public', 'q'=> country })
        .to_return(status: 401, body: json_response)

      response =  JSON.parse(json_response, symbolize_names: true)
      
      expect(response).to be_a(Hash)
      expect(response).to have_key(:status)
      expect(response).to have_key(:message)
      
      expect(response[:status]).to be_a(String)
      expect(response[:message]).to be_a(String)

      expect(response[:error]).to eq(nil)
    end

    it 'errors if api_id is missing' do
      country = 'thailand'
      json_response = File.read('spec/fixtures/service_responses/recipes/error_no_api_id.json')
      stub_request(:get, 'https://api.edamam.com/api/recipes/v2?')
        .with(query: {'app_key' => ENV['app_key'],'type' => 'public', 'q'=> country })
        .to_return(status: 401, body: json_response)

      response =  JSON.parse(json_response, symbolize_names: true)

      expect(response).to be_a(Hash)
      expect(response).to have_key(:status)
      expect(response).to have_key(:message)
      
      expect(response[:status]).to be_a(String)
      expect(response[:message]).to be_a(String)

      expect(response[:error]).to eq(nil)
    end

  end
end