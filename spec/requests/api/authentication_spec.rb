# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/authentication', type: :request do
  path 'api/v1/authentication' do
    post 'login user' do
      tags 'user signin'
      consumes 'application/json'
      parameter name: 'Authorization', in: :header, type: :string
      parameter name: :user, in: :body,
                schema: {
                  type: :object,
                  properties: {
                    username: { type: :string },
                    password: { type: :string }
                  },
                  required: %w[username password]
                }
      response '201', 'user logged in' do
        let(:user) { { username: 'username', password: 'password' } }
        run_test!
      end
      response '422', 'invalid request' do
        let(:user) { { username: 'username', password: 'password' } }
        run_test!
      end
    end
  end

  path 'api/v1/todos' do
    delete 'user logged out' do
      tags 'user logged out'
      produces 'application/json'
      parameter name: 'Authorization', in: :header, type: :string
      response '204', 'returns a nil authentication token' do
        let(:user) { { username: 'username', password: 'password' } }
        run_test!
      end
      response '422', 'invalid request' do
        let(:user) { { username: 'username', password: 'password' } }
        run_test!
      end
    end
  end
end
