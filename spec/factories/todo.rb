# frozen_string_literal: true

FactoryBot.define do
  factory :todo do
    title { Faker::TvShows::BigBangTheory.character }
  end
end
