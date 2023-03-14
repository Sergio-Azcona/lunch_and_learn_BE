class PhotosFacade
  def self.image_search(valid_country)
    images = PhotoService.unsplash_search(valid_country)
    
    all_photos = images[:results].map do |image|
      Photo.new(image)
    end

    if all_photos.nil?
      {}
    else
      all_photos.sort_by!{ |i|i.likes }.reverse.first(10) if images[:total_pages] >= 1 
    end

  end
end