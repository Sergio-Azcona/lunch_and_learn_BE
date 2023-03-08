require 'rails_helper'

RSpec.describe 'favorites#create Responses' do
  describe 'favorite successfully created' do  
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

  describe 'favorite NOT created' do
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

end