require 'rails_helper'

RSpec.describe 'favorited Responses' do
  describe 'favorites#create successfully created' do  
    it 'returns a success hash' do
        create_list(:user, 4)
          
        json_response = File.read('spec/fixtures/request_responses/favorites/post_success.json')
        incoming_params = ({country: 'thailand', recipe_link: "https://www.tastingtable.com/.....", recipe_title: "Crab Fried Rice (Khaao Pad Bpu)", user: User.second.api_key })

        stub_request(:post, 'http://localhost:3000/api/v1/favorites')
          .to_return(body: json_response)        

        response =  JSON.parse(json_response, symbolize_names: true)

        expect(User.second.api_key).to eq(incoming_params[:user])
        expect(response).to be_a(Hash)
        expect(response.keys).to eq([:success])
    end
  end

  describe 'favorites#create NOT created' do
    it 'returns a error hash' do
      create_list(:user, 4)
        
      json_response = File.read('spec/fixtures/request_responses/favorites/post_failed.json')
      incoming_params = ({country: 'thailand', recipe_link: "https://www.tastingtable.com/.....", recipe_title: "Crab Fried Rice (Khaao Pad Bpu)", user: '' })

      stub_request(:post, 'http://localhost:3000/api/v1/favorites')
        .to_return(body: json_response)   
        
      response =  JSON.parse(json_response, symbolize_names: true)
        
      expect(response).to be_a(Hash)
      expect(response.keys).to eq([:errors])

      expect(response[:errors]).to be_a(Array)
      expect(response[:errors].count).to eq(1)

      expect(response[:errors].first.keys).to eq([:error_message, :status])

      expect(response[:errors].first[:error_message]).to eq( "undefined method `favorites' for nil:NilClass")
      expect(response[:errors].first[:status]).to eq('400')
    end
  end

  describe 'favorites#index' do
    before(:each) do
      create_list(:user, 2)
      create_list(:favorite, 2)
    end

    describe 'favorites#index request successfully' do
      it 'response with attributes when favorites are present' do  
        json_response = File.read('spec/fixtures/request_responses/favorites/get_successful_attributes.json')

        user = Favorite.first.user

        stub_request(:get, "http://localhost:3000/api/v1/favorites?api_key=#{Favorite.first.user.api_key}")
          .to_return(body: json_response)   
          
        response =  JSON.parse(json_response, symbolize_names: true)
        # require 'pry';binding.pry
        expect(response).to be_a(Hash)
        expect(response.keys).to eq([:data])

        expect(response[:data]).to be_a(Array)
        expect(response[:data].count).to eq(6)

        expect(response[:data].first.keys).to eq([:id, :type, :attributes])
        expect(response[:data].first[:id]).to be_a(Integer)

        expect(response[:data].first[:type]).to be_a(String)
        expect(response[:data].first[:attributes]).to be_a(Hash)

        expect(response[:data].first[:attributes].keys).to eq([:recipe_title, :recipe_link, :country, :created_at])

        expect(response[:data].first[:attributes][:recipe_title]).to be_a(String)
        expect(response[:data].first[:attributes][:recipe_link]).to be_a(String)
        expect(response[:data].first[:attributes][:country]).to be_a(String)
        expect(response[:data].first[:attributes][:country]).to be_a(String)
      end

      it 'response with attributes when favorites are present' do  
        json_response = File.read('spec/fixtures/request_responses/favorites/get_successful_no_attributes.json')

        stub_request(:get, "http://localhost:3000/api/v1/favorites?api_key=#{User.first.api_key}")
          .to_return(body: json_response)   
          
        response =  JSON.parse(json_response, symbolize_names: true)

        expect(response).to be_a(Hash)
        expect(response.keys).to eq([:data])
        expect(response[:data].empty?).to eq(true)
      end
    end

    describe 'favorites#index request NOT successfully' do
      

    it 'returns json with error information' do
      json_response = File.read('spec/fixtures/request_responses/favorites/get_error_no_id.json')
    
        stub_request(:get, "http://localhost:3000/api/v1/favorites?api_key=  ")
          .to_return(body: json_response)   
          
      response =  JSON.parse(json_response, symbolize_names: true)

      # require 'pry';binding.pry
      
      expect(response).to be_a(Hash)
      expect(response.keys).to eq([:errors])
      expect(response[:errors]).to be_a(Array)
      expect(response[:errors].count).to eq(1)

      expect(response[:errors][0]).to be_a(Hash)
      expect(response[:errors][0].keys).to eq([:error_message, :status])

      expect(response[:errors][0][:error_message]).to be_a(String)
      expect(response[:errors][0][:error_message]).to eq("undefined method `favorites' for nil:NilClass")

      expect(response[:errors][0][:status]).to be_a(String)

      expect(response[:errors][0][:status]).to eq('404')
    end



    end
  end

end