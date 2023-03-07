require 'rails_helper'

RSpec.describe 'Places Service' do
  describe 'successful response' do
    describe 'return an index of places for a given coordinate' do
      it 'responds with expected keys and datatypes' do
        json_response = File.read('spec/fixtures/service_responses/places/final_sights_paris.json')
        stub_request(:get, 'https://api.geoapify.com/v2/places?')
        .with(query: {'apiKey' => ENV['apiKey'],'categories' => 'catering.restaurant','filter'=> 'circle:-73.4975,41.2841,12000'})      
        .to_return(status: 200, body: json_response)
        
        response =  JSON.parse(json_response, symbolize_names: true)
      
        expect(response).to be_a(Hash)
        expect(response).to have_key(:features)
        
        expect(response[:features]).to be_a(Array)

        response[:features].each do |feature|
          # require 'pry';binding.pry
          expect(feature).to have_key(:properties)
          expect(feature[:properties]).to be_a(Hash)

          expect(feature[:properties]).to have_key(:name)
          expect(feature[:properties]).to have_key(:address_line2)
          expect(feature[:properties]).to have_key(:place_id)

        end
      end
    end
  end

  describe 'unseccussful response' do
    it 'returns error when invalid apiKey is given' do
      json_response = File.read('spec/fixtures/service_responses/places/error_invalid_api_key.json')
        stub_request(:get, 'https://api.geoapify.com/v2/places?categories=catering.restaurant&filter=circle:2.33,48.87,20000')   
        .to_return(body: json_response)
        
        response =  JSON.parse(json_response, symbolize_names: true)
        # require 'pry';binding.pry
        expect(response).to be_a(Hash)
        expect(response).to have_key(:statusCode)
        expect(response).to have_key(:error)
        expect(response).to have_key(:message)
    
        expect(response[:statusCode]).to be_a(Integer)
        expect(response[:statusCode]).to eq(401)

        expect(response[:error]).to be_a(String)
        expect(response[:message]).to be_a(String)
    end

    it 'returns error if no category is provided' do
      json_response = File.read('spec/fixtures/service_responses/places/error_no_category_param.json') 
      stub_request(:get, 'https://api.geoapify.com/v2/places?')
      .with(query: {'apiKey' => ENV['apiKey'],'filter'=> 'circle:-73.4975,41.2841,12000'})      
      .to_return(body: json_response)
      
      response =  JSON.parse(json_response, symbolize_names: true)
    
      expect(response).to be_a(Hash)
      expect(response).to have_key(:statusCode)
  
      expect(response[:statusCode]).to be_a(Integer)
      expect(response[:statusCode]).to eq(400)

      expect(response[:error]).to be_a(String)
      expect(response[:message]).to be_a(String)
    end

    it 'returns error if no coordinates are provided' do
      json_response = File.read('spec/fixtures/service_responses/places/error_no_coordinates_param.json') 
      stub_request(:get, 'https://api.geoapify.com/v2/places?')
      .with(query: {'apiKey' => ENV['apiKey'],'categories' => 'tourism.sights','filter'=> 'circle:'})      
      .to_return(body: json_response)
      
      response =  JSON.parse(json_response, symbolize_names: true)
    
      expect(response).to be_a(Hash)
      expect(response).to have_key(:statusCode)
  
      expect(response[:statusCode]).to eq(400)

      expect(response[:error]).to be_a(String)
      expect(response[:message]).to be_a(String)
    end

  end
end