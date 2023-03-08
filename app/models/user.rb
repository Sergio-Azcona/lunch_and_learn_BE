class User < ApplicationRecord
  before_validation :generate_api_key, on: :create

  validates_presence_of :name, :email
  validates_uniqueness_of :email

  private
  def generate_api_key
    self.api_key = SecureRandom.urlsafe_base64
  end

end
