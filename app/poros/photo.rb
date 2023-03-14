class Photo
  attr_reader :alt_tag, :url, :likes
  def initialize(data)
    @alt_tag = data[:alt_description]
    @url = data[:urls][:raw]
    @likes = data[:likes]
  end


end