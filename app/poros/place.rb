class Place
  attr_reader :name, :address, :place_id

  def initialize(data)
    # require 'pry';binding.pry
    @name = data[:properties][:name]
    @address = data[:properties][:address_line2]
    @place_id = data[:properties][:place_id]
  end
end