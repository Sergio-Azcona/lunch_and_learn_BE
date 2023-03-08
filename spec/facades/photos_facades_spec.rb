# require 'rails_helper'

# RSpec.describe 'Photos Facade' do
#   before(:each) do
#     stub_request(:get, "https://api.unsplash.com/search/photos?client_id=ACSDvOULHchgCZzn4uYQS4_BhaxvY9SQu2BwyvKr-eo&page=1&per_page=100&query=aruba").
#          with(
#            headers: {
#           'Accept'=>'*/*',
#           'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
#           'User-Agent'=>'Faraday v2.7.4'
#            }).
#          to_return(status: 200, body:  @request, headers: {})

#     @request = PhotosFacade.image_search('aruba')
#   end

#   it 'returns an array ordered by :likes' do

#   expect( @request).to be_a(Array)
#   require 'pry';binding.pry
#   # expect(request[0].next[:likes]).to be >=(request[1].next[:likes])

#   # (request[0][:likes]) >= (request[1][:likes])

#   end
# end
