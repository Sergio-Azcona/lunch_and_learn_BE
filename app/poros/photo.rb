class Photo
  attr_reader :alt_tag, :url, :likes
  def initialize(data)
    @alt_tag = data[:alt_description].to_json
    @url = data[:urls][:raw].to_json
    @likes = data[:likes]
  end


end