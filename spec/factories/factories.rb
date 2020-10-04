# frozen_string_literal: false

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test-#{n.to_s.rjust(3, '0')}@example.com" }
    password { '123456' }
  end

  factory :category do 
    name {'comida'}
    description {'categoria para los gastos de comida'}
  end

  factory :account do 
    user
    balance {3000}
    type {"credito"}
    currency {"US"}
    quota {"200"}
  end
  
end
