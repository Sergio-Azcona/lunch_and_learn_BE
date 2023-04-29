class PhotosFacade
  def self.image_search(valid_country)
    images = PhotoService.unsplash_search(valid_country)
    
    top_photos = images[:results].sort_by!{ |pic| pic[:likes] }.reverse.first(10) if images[:total_pages] > 0 

    top_photos = images[:results].map do |image|
      Photo.new(image)
    end

  end
end