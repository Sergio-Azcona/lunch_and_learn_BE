require 'rails_helper'

RSpec.describe 'users#create Responses' do
  describe 'User creation successful response' do  
    
    it 'if recipies exist, returns the expected top level and attributes keys' do 
      name = 'Athena Dao'
      email = '3athenadao@bestgirlever.com'
      
      json_response = File.read('spec/fixtures/request_responses/users/success_reponse.json')
      
      stub_request(:post, 'http://localhost:3000/api/v1/users')
        .with(query: {'name'=> name, 'email'=> email})
        .to_return(body: json_response)        
      
      response =  JSON.parse(json_response, symbolize_names: true)
      
      expect(response).to be_a(Hash)
      expect(response.keys).to eq([:data])

      expect(response[:data]).to be_a(Hash)
      expect(response[:data].keys).to eq([:type, :id, :attributes])

      expect(response[:data][:type]).to be_a(String)
      expect(response[:data][:id]).to be_a(String)
      expect(response[:data][:attributes]).to be_a(Hash)

      expect(response[:data][:attributes].keys).to eq([:name, :email, :api_key])
      expect(response[:data][:attributes][:name]).to be_a(String)
      expect(response[:data][:attributes][:email]).to be_a(String)
      expect(response[:data][:attributes][:api_key]).to be_a(String)

      expect(response[:data][:attributes][:name]).to eq(name)
      expect(response[:data][:attributes][:email]).to eq(email)
    end
  end
  describe 'User creation UNsuccessful response' do  
    it 'returns json with error information' do
      create_list(:user, 4)
      name = 'Athena Smith'
      email = '3athenadao@bestgirlever.com'
      
      json_response = File.read('spec/fixtures/request_responses/users/error_response.json')
      user_params = ({'name'=> name, 'email'=> email})

      stub_request(:post, 'http://localhost:3000/api/v1/users')
        .to_return(body: json_response)        
      
      response =  JSON.parse(json_response, symbolize_names: true)
      # require 'pry';binding.pry

      expect(User.last).to_not eq(user_params)
      
      expect(response).to be_a(Hash)
      expect(response.keys).to eq([:errors])
      expect(response[:errors]).to be_a(Array)
      expect(response[:errors].count).to eq(1)

      expect(response[:errors][0]).to be_a(Hash)
      expect(response[:errors][0].keys).to eq([:error_message, :status])

      expect(response[:errors][0][:error_message]).to be_a(String)
      expect(response[:errors][0][:status]).to be_a(String)

      expect(response[:errors][0][:status]).to eq('422')
    end


  end
end