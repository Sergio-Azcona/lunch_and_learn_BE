require 'rails_helper'

RSpec.describe 'Tourist Sights API Responses' do
  describe 'search by country' do
    it 'response with the expected datatypes and structure' do  

      json_response = File.read('spec/fixtures/request_responses/final_tourist_sights.json')
      stub_request(:get, 'https://api.geoapify.com/v2/places?')
      .with(query: {'apiKey' => ENV['apiKey'],'categories' => 'catering.restaurant','filter'=> 'circle:-73.4975,41.2841,12000'})      
      .to_return(status: 200, body: json_response)
      
      response =  JSON.parse(json_response, symbolize_names: true)

        expect(response).to be_a(Hash)
        expect(response).to have_key(:data)
        expect(response[:data]).to be_a(Array)

        response[:data].each do |recipe|
          expect(recipe).to have_key(:id)
          expect(recipe[:id]).to be_a(String)
          expect(recipe[:id]).to eq('null')

          expect(recipe).to have_key(:type)
          expect(recipe[:type]).to be_a(String)
          expect(recipe[:type]).to eq('place')

          expect(recipe).to have_key(:attributes)
          expect(recipe[:attributes]).to be_a(Hash)
          
          expect(recipe[:attributes]).to have_key(:name)
          expect(recipe[:attributes]).to have_key(:address)
          expect(recipe[:attributes]).to have_key(:place_id)
          # require 'pry';binding.pry
          expect(recipe[:attributes][:name]).to be_a(String)

          expect(recipe[:attributes][:address]).to be_a(String)
          expect(recipe[:attributes][:place_id]).to be_a(String)


        end
    end

  end

end