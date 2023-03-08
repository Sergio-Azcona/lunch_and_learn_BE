class Favorite < ApplicationRecord
  # belongs_to :api_key
  belongs_to :user

  validates_presence_of :country, :recipe_link, :recipe_title

end
