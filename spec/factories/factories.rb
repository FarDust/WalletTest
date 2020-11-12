# frozen_string_literal: false

require('account')
# Deshabilitamos esta regla para hacer tests

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
    balance { 3000 }
    account_type { 'common' }
    balance_currency { 'CLP' }
    quota { 200 }
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

  factory :transaction do
    user
    association :origin_movement, factory: :movement
    association :target_movement, factory: :movement
  end
end
