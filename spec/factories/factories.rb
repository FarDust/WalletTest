# frozen_string_literal: false

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test-#{n.to_s.rjust(3, '0')}@example.com" }
    password { '123456' }
  end
  factory :account do
    balance { 300 }
    type { 'corriente' }
    currency { 'usd' }
  end
end
