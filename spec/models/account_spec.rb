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

# rubocop:disable Metrics/BlockLength

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

    it 'debit cannot have negative balance' do
      account = build(:account, account_type: 'debt', balance: -1)
      expect(account).not_to(be_valid)
    end

    it 'debit cannot have quota' do
      account = build(:account, account_type: 'debt', balance: 1, quota: 0)
      expect(account.quota).to(eq(0))
    end

    it 'credit cannot have postive balance' do
      account = build(:account, account_type: 'credit', balance: 1)
      expect(account).not_to(be_valid)
    end

    it 'credit balance cannot exceed quota' do
      account = build(:account, account_type: 'credit', balance: -2, quota: 1)
      expect(account).not_to(be_valid)
    end

    it 'has proper type' do
      account = build(:account)
      expect(account.types_guard).to(eq(true))
    end

    it 'dont have proper type' do
      account = build(:account, account_type: 'test')
      expect(account.types_guard).to(eq(false))
    end
  end

  context 'when exists common_account' do
    it 'accepts new ammount' do
      account = create(:account)
      expect(account.can_transact?(200)).to(eq(true))
    end

    it 'doesnt accepts amount 0' do
      account = create(:account)
      expect(account.can_transact?(nil)).to(eq(false))
    end

    it 'matches his names' do
      account = create(:account)
      expect(account.name).to(match(account.id.to_s))
    end

    it 'matches his personal identifier' do
      account = create(:account)
      expect(account.personal_account_identifier)
        .to(match(account.account_type))
    end

    it 'matches his public identifier' do
      account = create(:account)
      expect(account.public_account_identifier)
        .to(match(account.user.email))
    end
  end

  context 'when exists debt_account' do
    it 'accepts new amount' do
      account = create(:account, account_type: 'debt')
      expect(account.can_transact?(200)).to(eq(true))
    end

    it 'cant transact with negative balance' do
      account = create(:account, account_type: 'debt')
      expect(account.can_transact?(-6000)).to(eq(false))
    end
  end

  context 'when exists creadit_account' do
    it 'accepts new amount' do
      account = create(:account,
                       account_type: 'credit',
                       balance: -200,
                       quota: 3000)
      expect(account.can_transact?(100)).to(eq(true))
    end

    it 'cant transact with positive balance' do
      account = create(:account,
                       account_type: 'credit',
                       balance: -200,
                       quota: 3000)
      expect(account.can_transact?(300)).to(eq(false))
    end
  end

  context 'when update debt account' do
    it 'use invalid quota' do
      account = build(:debt_account)
      account.save
      account.update({ quota: 200 })
      expect(account.debt_guard).not_to(be_truthy)
    end
  end
end
# rubocop:enable Metrics/BlockLength
