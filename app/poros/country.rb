class Country
  attr_reader :common_name
  def initialize(info)
    # require 'pry';binding.pry
    # @official_name = info[:official]
    @common_name = info[:name][:common]
  end

end