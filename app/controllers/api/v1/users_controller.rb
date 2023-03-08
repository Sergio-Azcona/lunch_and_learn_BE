class Api::V1::UsersController < ApplicationController  
  def create
    # require 'pry';binding.pry
    new_user = User.new(user_params)

    if new_user.save
      render json: UserSerializer.show_serialize(new_user), status: 201
    else
      render json: ErrorSerializer.serialized_response(new_user.errors.messages.first.second, 400), status: 400
    end
    
    # begin 
    #   new_user.save
    #   # new_user = User.create!(user_params)
    #   # require 'pry';binding.pry
    #   render json: UserSerializer.show_serialize(new_user) 

    # rescue => error
    #   # require 'pry';binding.pry
    #   render json: ErrorSerializer.serialized_response(error, 422), status: 422
    # end
  end


  private

  def user_params
    params.require(:user).permit(:name, :email)

  end
end