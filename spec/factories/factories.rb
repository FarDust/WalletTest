# frozen_string_literal: false

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test-#{n.to_s.rjust(3, '0')}@example.com" }
    password { '123456' }
  end

  factory :category do
    name { 'comida' }
    description { 'categoria para los gastos de comida' }
  end

  factory :account do
    user
    balance_cents { 3000 }
    account_type { 'credit' }
    quota { '200' }
  end

  factory :common_account do
    user
    balance_cents { 100 }
    account_type { 'common' }
  end

  factory :debt_account do
    user
    balance_cents { 100 }
    account_type { 'debt' }
  end

  factory :natural_person do
    nombre { 'Jhon' }
    apellido { 'Doe' }
    rut { '11111111-1' }
  end

  factory :movement do
    category
    account
    final_balance { 2322 }
    amount { 2323 }
  end
end
