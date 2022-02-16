# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Authentications', type: :request do
  describe 'POST /auth/login' do
    let!(:user) { create(:user) }
    let(:headers) { valid_headers.except('Authorization') }

    let(:valid_credentials) do
      {
        username: user.username,
        password: user.password
      }.to_json
    end

    let(:invalid_credentials) do
      {
        username: Faker::Movie.name,
        password: Faker::Internet.password
      }.to_json
    end

    context 'When request is valid' do
      before { post '/auth/login', params: valid_credentials, headers: headers }

      it 'returns an authentication token' do
        expect(json['auth_token']).not_to be_nil
      end
    end

    context 'When request is invalid' do
      before { post '/auth/login', params: invalid_credentials, headers: headers }

      it 'returns a failure message' do
        expect(json['message']).to match(/Invalid credentials/)
      end
    end

    describe 'DELETE/auth/signout' do
      let(:user) { create(:user) }
      let!(:user_token) { token_generator(user.id) }
      let!(:headers) { { 'Authorization' => user_token } }

      context 'logout user' do
        before do
          delete '/auth/signout', headers: headers
        end

        it 'returns a nil authentication token' do
          expect(json['auth_token']).to be_nil
        end
      end
    end
  end
end
