class V1::UsersController < ApplicationController
  def create
    render json: User.create.to_json(only: :token)
  end
end
