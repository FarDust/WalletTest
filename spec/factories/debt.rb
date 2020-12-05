# frozen_string_literal: false

FactoryBot.define do
  factory :debt do
    amount { 3000 }
    for_user
    currency { 'CLP' }
    interest { 1234 }

    trait :for_user do
      acreedor_type { 'User' }
      deudor_type { 'User' }
      association :acreedor, factory: :user
      association :deudor, factory: :user
    end

    trait :for_natural_acreedor do
      acreedor_type { 'NaturalPerson' }
      deudor_type { 'User' }

      association :acreedor, factory: :natural_person
      association :deudor, factory: :user
    end

    trait :for_natural_deudor do
      acreedor_type { 'User' }
      deudor_type { 'NaturalPerson' }

      association :acreedor, factory: :user
      association :deudor, factory: :natural_person
    end
  end
end
