class Country
  attr_reader :common_name, :capital_latitude, :capital_longitude
  def initialize(info)
    # require 'pry';binding.pry
    @common_name = info[:name][:common]
    @capital = info[:capital].first
    @capital_latitude = info[:capitalInfo][:latlng].first
    @capital_longitude = info[:capitalInfo][:latlng].second
  end

end