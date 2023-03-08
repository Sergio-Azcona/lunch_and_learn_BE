require 'rails_helper'

RSpec.describe 'Photo Service' do
  describe 'successful response' do
    before(:each) do
      @country =  'france'
    
      @json_response = File.read('spec/fixtures/service_responses/photos/success_photo_return.json')
      stub_request(:get, "https://api.unsplash.com/search/photos?")
      .with(query: {'client_id' => ENV['access_key'],'page' => '1','per_page'=> '100','query'=> @country} )      
      .to_return(status: 200, body: @json_response)
    end
    
    it 'it returns data about a country' do  
      response =  JSON.parse(@json_response, symbolize_names: true)
      expect(response).to be_a(Hash)
      expect(response.keys).to eq([:total,:total_pages,:results])

      expect(response[:results]).to be_a(Array)
      expect(response[:results][0]).to have_key(:alt_description)
      expect(response[:results][0][:alt_description]).to be_a(String)

      expect(response[:results][0]).to have_key(:urls)
      expect(response[:results][0][:urls]).to be_a(Hash)

      expect(response[:results][0][:urls]).to have_key(:raw)
      expect(response[:results][0][:urls][:raw]).to be_a(String)

      #'likes' are used to order the list of photos recieved from greatest to least likes (popularity)
      expect(response[:results][0]).to have_key(:likes)

    end

  end


end