require 'rails_helper'

RSpec.describe 'Video Service' do
  describe 'successful response' do
    before(:each) do
      @country =  'Cameroon'
      @channel_id = 'UCluQ5yInbeAkkeCndNnUhpw'
      @video_type = 'video'

      @json_response = File.read('spec/fixtures/service_responses/videos/found_videos.json')
      stub_request(:get, 'https://api.edamam.com/api/recipes/v2?')
        .with(query: {'key' => ENV['key'], 'part' => 'snippet','channelId' => @channel_id, 'type'=> @video_type , 'q'=> @country })
        .to_return(status: 200, body: @json_response)
    
      @response =  JSON.parse(@json_response, symbolize_names: true)
    end

    it 'it returns data about a country' do  
      expect(@response).to be_a(Hash)
      expect(@response).to have_key(:items)
      
      expect(@response[:items]).to be_a(Array)
      expect(@response[:items][0]).to have_key(:snippet)
      expect(@response[:items][0][:snippet]).to be_a(Hash)
      
      expect(@response[:items][0][:snippet]).to have_key(:title)
      expect(@response[:items][0][:snippet][:title]).to be_a(String)

    end
      
    it 'the video contains the needed attributes' do
      expect(@response[:items].count).to eq(5)
      
      #iterating to find the video's country 
      country_video = @response[:items].select do |v|
        v[:snippet][:title].include?(@country) 
      end
      
      expect(country_video).to be_a(Array)
      expect(country_video.count).to eq(1)

      video = country_video.first

      expect(video).to be_a(Hash)
      expect(video.keys).to eq([:kind, :etag, :id, :snippet])

      expect(video[:id]).to be_a(Hash)
      expect(video[:id].keys).to eq([:kind, :videoId])
      expect(video[:id][:kind].include?(@video_type)).to eq(true)
      expect(video[:id][:videoId]).to be_a(String)


      expect(video[:snippet]).to be_a(Hash)
      expect(video[:snippet]).to have_key(:title)
      expect(video[:snippet][:title]).to include(@country)
      
      expect(video[:snippet]).to have_key(:channelId)
      expect(video[:snippet][:channelId]).to eq(@channel_id)
    end

  end
end