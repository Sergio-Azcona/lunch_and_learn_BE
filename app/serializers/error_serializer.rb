class ErrorSerializer
  def self.serialized_response(error, status_code)
    # require 'pry';binding.pry
    {
        "errors":
        [ 
          {
          "error_message":  error.message,
          "status": status_code.to_s, 
          } 
        ]
    }
  end
end