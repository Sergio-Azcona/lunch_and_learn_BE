require 'rails_helper'

RSpec.describe 'Country Service' do
  describe '#capital_city_coordinates' do
    it 'it returns data about a country' do  
      country =  'france'
      
      json_response = File.read('spec/fixtures/service_responses/countries/final_service_france_country.json')
      stub_request(:get, "https://restcountries.com/v3.1/name/#{country}")
      .with(query: {'apiKey' => ENV['apiKey'],'categories' => 'catering.restaurant','filter'=> 'circle:-73.4975,41.2841,12000'})      
      .to_return(status: 200, body: json_response)

      response =  JSON.parse(json_response, symbolize_names: true)
      
      expect(response).to be_a(Array)
      expect(response.count).to eq(1) #one element in the array - ie only one country returned

      response.each do |data|
        expect(response).to be_a(Hash)
        expect(data).to have_key(:capital)
        require 'pry';binding.pry  
        expect(data[:capital]).to be_a(Array)
        expect(data[:capital].count).to eq(1) #only one value - 1 capital
        expect(data[:capital][0]).to be_a(String)

        expect(data).to have_key(:capitalInfo)
        expect(data[:capitalInfo]).to be_a(Hash)
        expect(data[:capitalInfo]).to have_key(:latlng)
        expect(data[:capitalInfo][:latlng]).to be_a(Array)
        expect(data[:capitalInfo][:latlng].count).to eq(2) #have two coordinates
        expect(data[:capitalInfo][:latlng].first).to be_a(Float)
        expect(data[:capitalInfo][:latlng].last).to be_a(Float)
      end

    end
  end

end