require 'rails_helper'

RSpec.describe 'Recipes API Responses' do

  describe 'search by country' do
    describe 'successful response' do  
      describe 'when country and recipies exist' do
        it 'if recipies exist, returns the expected top level and attributes keys' do 
          country = 'thailand'
          json_response = File.read('spec/fixtures/request_responses/recipes/recipes_index_response_for_thailand.json')
          
          stub_request(:get, 'https://localhost:3000/api/v1/recipes?')
            .with(query: {'country'=> country })
            .to_return(status: 200, body: json_response)        
          
          response =  JSON.parse(json_response, symbolize_names: true)

          expect(response).to be_a(Hash)
          expect(response).to have_key(:data)
          expect(response.count).to eq(1)

          expect(response[:data]).to be_a(Array)
          
          response[:data].each do |recipe|
            expect(recipe.count).to eq(3)
            expect(recipe).to have_key(:id)
            expect(recipe[:id]).to be_a(String)
            expect(recipe[:id]).to eq('null')
            
            expect(recipe).to have_key(:type)
            expect(recipe[:type]).to be_a(String)
            expect(recipe[:type]).to eq('recipe')

            expect(recipe).to have_key(:attributes)
            expect(recipe[:attributes]).to be_a(Hash)
          
            expect(recipe[:attributes].count).to eq(4)
            expect(recipe[:attributes]).to have_key(:title)
            expect(recipe[:attributes]).to have_key(:url)
            expect(recipe[:attributes]).to have_key(:country)
            expect(recipe[:attributes]).to have_key(:image)
          end
        end

        it 'if recipies exist, attribute keys return the expected value datatype; country matches the value passed in' do
          country = 'thailand'
          json_response = File.read('spec/fixtures/request_responses/recipes/recipes_index_response_for_thailand.json')
          stub_request(:get, 'https://localhost:3000/api/v1/recipes?')
            .with(query: {'country'=> country })
            .to_return(status: 200, body: json_response)        
          
          response =  JSON.parse(json_response, symbolize_names: true)
          
          response[:data].each do |recipe|
            expect(recipe[:attributes][:title]).to be_a(String)
            expect(recipe[:attributes][:url]).to be_a(String)
            expect(recipe[:attributes][:country]).to be_a(String)
            expect(recipe[:attributes][:country]).to eq(country)
            expect(recipe[:attributes][:image]).to be_a(String)
          end
        end
      end

      describe 'when country or recipes does not exists' do
        it 'when country is an empty string or nil, or recipies is nil, returns data with an empty array' do
          country = ''
          @json_response = File.read('spec/fixtures/request_responses/recipes/no_recipes_response.json')
          stub_request(:get, "https://localhost:3000/api/v1/recipes?country=#{country}")
            .to_return(status: 200, body: @json_response)        
          response =  JSON.parse(@json_response, symbolize_names: true)
    
          expect(response).to be_a(Hash)
          expect(response).to have_key(:data)
          expect(response.count).to eq(1)
          
          expect(response[:data].nil?).to eq(false)
          expect(response[:data]).to be_a(Array)
          expect(response[:data][0].nil?).to eq(true)

        end
      end
    end
  end
end