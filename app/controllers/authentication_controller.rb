# frozen_string_literal: true

class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: :authenticate

  def authenticate
    auth_token = AuthenticateUser.new(auth_params[:username], auth_params[:password]).call
    json_response(auth_token: auth_token)
  end

  def destroy
    @user = current_user
    @user.update(user_token: nil) if @user.present?
  end

  private

  def auth_params
    params.permit(:username, :password)
  end
end
