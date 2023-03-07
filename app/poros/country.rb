class Country
  attr_reader :common_name, :capital_latitude, :capital_longitude
  def initialize(info)
    # require 'pry';binding.pry
    @common_name = info[:name][:common]
    @capital = info[:capital].first #unless [:capital].first == nil
    @capital_latitude = info[:capitalInfo][:latlng].first #unless [:capitalInfo][:latlng].first == nil
    @capital_longitude = info[:capitalInfo][:latlng].second #unless [:capitalInfo][:latlng].second == nil
  end
end