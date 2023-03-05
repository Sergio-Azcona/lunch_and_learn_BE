require 'rails_helper'

RSpec.describe 'Recipes API Responses' do

    describe 'search by country' do
      it 'returns a successful response with the expected top level and attributes keys' do 
        country = 'thailand'
        json_response = File.read('spec/fixtures/recipes_index_response_for_thailand.json')
        stub_request(:get, 'https://localhost:3000/api/v1/recipes?')
          .with(query: {'country'=> country })
          .to_return(status: 200, body: json_response)        
        
        response =  JSON.parse(json_response, symbolize_names: true)
          require 'pry';binding.pry
          expect(response).to be_a(Hash)


      end
    end

end