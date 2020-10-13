# frozen_string_literal: false

FactoryBot.define do
  factory :debt do
    amount { 3000 }
    for_user

    trait :for_user do
      association :acreedor, factory: :user
      association :deudor, factory: :user
    end

    trait :for_natural_acreedor do
      association :acreedor, factory: :natural_person
      association :deudor, factory: :user
    end

    trait :for_natural_deudor do
      association :acreedor, factory: :user
      association :deudor, factory: :natural_person
    end
  end
end
