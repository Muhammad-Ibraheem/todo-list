# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    username { Faker::Name.user_name }
    'password_digest { "testing" }'
  end
end
