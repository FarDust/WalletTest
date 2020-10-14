# frozen_string_literal: true

# == Schema Information
#
# Table name: accounts
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  balance    :integer
#  type       :string
#  currency   :string
#  quota      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require('rails_helper')

RSpec.describe(Account, type: :model) do
  context 'with attributes val ' do
    it { is_expected.to(validate_presence_of(:balance_cents)) }
    it { is_expected.to(validate_presence_of(:account_type)) }
  end

  context 'with associations val' do
    it { is_expected.to(belong_to(:user).required) }
  end

  context 'when create account' do
    it 'use valid data' do
      account = build(:account)
      expect(account).to(be_valid)
    end
    it 'credit cannot have postive balance' do
      account = build(:account, account_type: "credit", balance: 1)
      expect(account).not_to be_valid
    end
    it 'credit balance cannot exceed quota' do
      account = build(:account, account_type: "credit", balance: -2, quota: 1)
      expect(account).not_to be_valid
    end
    # falta generar validor para que otros tipos de cuentan no tengan balance negativo
  end

  context 'when update debt account' do
    it 'use invalid quota' do
      account = build(:debt_account)
      expect(account.update({ quota: 200 })).not_to(be_truthy)
    end
  end
end
