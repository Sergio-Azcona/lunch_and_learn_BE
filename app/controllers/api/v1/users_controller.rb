class Api::V1::UsersController < ApplicationController  
  def create   
    begin 
      new_user = User.create!(user_params)
      render json: UserSerializer.show_serialize(new_user), status: 201
    rescue => error
      render json: ErrorSerializer.serialized_response(error, 422), status: 422
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :email)

  end
end