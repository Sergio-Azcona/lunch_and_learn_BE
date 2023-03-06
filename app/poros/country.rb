class Country
  attr_reader :common_name
  def initialize(info)
    @common_name = info[:name][:common]
  end
end