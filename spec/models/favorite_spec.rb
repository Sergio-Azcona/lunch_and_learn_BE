require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe 'validations and relationship' do

    it { should validate_presence_of  :country }
    it { should validate_presence_of  :recipe_link }
    it { should validate_presence_of  :recipe_title }
    it { should validate_presence_of  :recipe_link }

    it { should belong_to(:user) }


  end
end
