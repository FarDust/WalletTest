# frozen_string_literal: false

FactoryBot.define do
  factory :debt_account, class: 'Account' do
    user
    balance { 3000 }
    account_type { 'debt' }
    balance_currency { 'CLP' }
    quota { 0 }
  end

  factory :account do
    user
    balance { 3000 }
    account_type { 'common' }
    balance_currency { 'CLP' }
    quota { 200 }
  end
end
