# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :authorize_request, only: :create

  def create
    user = User.new(user_params)
    if user.save!
      auth_token = AuthenticateUser.new(user.username, user.password).call
      response = { message: Message.account_created, auth_token: auth_token }
      json_response(response, :created)
    end
  end

  private

  def user_params
    params.permit(
      :username,
      :password
    )
  end
end
