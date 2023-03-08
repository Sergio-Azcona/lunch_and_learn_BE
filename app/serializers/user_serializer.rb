class UserSerializer
  def self.show_serialize(user)
    # require 'pry';binding.pry
    {
      "data": {
            "type": user.class.to_s.downcase,
            "id": user.id.to_s,
            "attributes": {
                        "name": user.name,
                        "email": user.email,
                        "api_key": user.api_key 
                      }
            }
    }
  end 
end