require 'rails_helper'

RSpec.describe 'Learning Resources API Responses' do

  describe 'successful response' do  
    describe 'returns the expected keys and datatypes' do
      describe 'when attributes are present' do
        before(:each) do 
          @country = 'Dominican Republic'
          @json_response = File.read('spec/fixtures/request_responses/learning_resources/includes_attributes.json')
          stub_request(:get, 'http://localhost:3000/api/v1/learning_resources?')
            .with(query: {'country'=> @country })
            .to_return(status: 200, body: @json_response)        
        end
        it 'returns top level keys and datatypes ' do 
          response =  JSON.parse(@json_response, symbolize_names: true)
          expect(response).to be_a(Hash) 
          expect(response).to have_key(:data)
          
          expect(response[:data]).to be_a(Hash)
          expect(response[:data].count).to eq(3)
          expect(response[:data].keys).to eq([:id, :type, :attributes])

          expect(response[:data][:id]).to eq('null')
          expect(response[:data][:type]).to eq('learning_resources')
          expect(response[:data][:attributes]).to be_a(Hash)
        end

        describe 'when attributes ARE present' do
          it 'returns the expected attribute keys and data types' do
            response =  JSON.parse(@json_response, symbolize_names: true)
            expect(response[:data][:attributes].count).to eq(3)
            expect(response[:data][:attributes].keys).to eq([:country, :video, :images])
            
            expect(response[:data][:attributes][:country]).to be_a(String)
            expect(response[:data][:attributes][:country]).to eq(@country)

            expect(response[:data][:attributes][:video]).to be_a(Hash)
            expect(response[:data][:attributes][:video].count).to eq(2)
            expect(response[:data][:attributes][:video].keys).to eq([:title, :youtube_video_id])
            expect(response[:data][:attributes][:video][:title]).to be_a(String)
            expect(response[:data][:attributes][:video][:youtube_video_id]).to be_a(String)

            expect(response[:data][:attributes][:images]).to be_a(Array)
            expect(response[:data][:attributes][:images].count).to be <=(10)

            expect(response[:data][:attributes][:images][0]).to be_a(Hash) 
            expect(response[:data][:attributes][:images][0].keys).to eq([:alt_tag, :url])
            
            expect(response[:data][:attributes][:images][0][:alt_tag]).to be_a(String)
            expect(response[:data][:attributes][:images][0][:url]).to be_a(String)

          end
        end

        describe 'when attributes are NOT present' do
          before(:each) do
            @country = 'march'
            @json_response = File.read('spec/fixtures/request_responses/learning_resources/no_attributes_return.json')
          end

          it 'video is an empty hash and images an empty array' do
            response =  JSON.parse(@json_response, symbolize_names: true)
            
            expect(response[:data][:attributes].keys).to eq([:country, :video, :images])
            
            expect(response[:data][:attributes][:country]).to be_a(String)
            expect(response[:data][:attributes][:country]).to eq(@country)

            expect(response[:data][:attributes][:video]).to be_a(Hash)
            expect(response[:data][:attributes][:video].empty?).to eq(true)
            expect(response[:data][:attributes][:video].keys).to_not eq([:title, :youtube_video_id])

            expect(response[:data][:attributes][:images]).to be_a(Array)
            expect(response[:data][:attributes][:images].empty?).to eq(true)
      
          end
        end
      end
    end
  end
end