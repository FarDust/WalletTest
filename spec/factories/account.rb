# frozen_string_literal: false

FactoryBot.define do
  factory :debt_account, class: 'Account' do
    user
    balance { 3000 }
    account_type { 'debt' }
    balance_currency { 'CLP' }
    quota { 0 }
  end

  factory :credit_account, class: 'Account' do
    user
    balance { -500 }
    account_type { 'credit' }
    balance_currency { 'CLP' }
    quota { -1000 }
  end

  factory :account do
    user
    balance { 3000 }
    account_type { 'common' }
    balance_currency { 'CLP' }
    quota { 200 }
  end
end
