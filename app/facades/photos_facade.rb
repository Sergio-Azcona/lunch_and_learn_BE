class PhotosFacade
  def self.image_search(valid_country)
    images = PhotoService.unsplash_search(valid_country)
    
    images[:results].sort_by!{ |i| i[:likes] }.reverse.first(10) if images[:total_pages] >= 1 
  end
end