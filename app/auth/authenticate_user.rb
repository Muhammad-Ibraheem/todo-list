# frozen_string_literal: true

class AuthenticateUser
  def initialize(username, password)
    @username = username
    @password = password
  end

  def call
<<<<<<< HEAD
    @token = JsonWebToken.encode(user_id: user.id) if user
    user.update(user_token: @token)
=======
    JsonWebToken.encode(user_id: user.id) if user
>>>>>>> main
  end

  private

  attr_reader :username, :password

  def user
    user = User.find_by(username: username)
    return user if user&.authenticate(password)

    raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
  end
end
