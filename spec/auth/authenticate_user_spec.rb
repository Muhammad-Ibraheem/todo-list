# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthenticateUser do
  let(:user) { create(:user) }
  subject(:valid_auth_obj) { described_class.new(user.username, user.password) }
  subject(:invalid_auth_obj) { described_class.new('foo', 'bar') }

  # Test suite for AuthenticateUser#call

  describe  '#call' do
    context 'when valid credentials' do
      it 'returns an auth token' do
        token = valid_auth_obj.call
        expect(token).not_to be_nil
      end
    end

    # raise Authentication Error when invalid request

    context 'when invalid credentials' do
      it 'raises an authentication error' do
        expect { invalid_auth_obj.call }
          .to raise_error(
            ExceptionHandler::AuthenticationError
          )
      end
    end
  end
end
