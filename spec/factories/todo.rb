# frozen_string_literal: true

FactoryBot.define do
  factory :todo do
    title { Faker::Quote.famous_last_words }
  end
end
