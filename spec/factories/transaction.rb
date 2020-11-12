# frozen_string_literal: false

FactoryBot.define do
  factory :transaction do
    user
    association :origin_movement, factory: :movement
    association :target_movement, factory: :movement
  end
end
