# frozen_string_literal: true

class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: :authenticate

  def authenticate
    auth_token = AuthenticateUser.new(auth_params[:username], auth_params[:password]).call
    json_response(auth_token: auth_token)
  end

  def destroy
    @user = current_user
    Rails.cache.write("InvalidJWTs-#{@user.id}", request.headers['Authorization'].split(' '), expires_in: 24.hours)
  end

  private

  def auth_params
    params.permit(:username, :password)
  end
end
