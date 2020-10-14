# frozen_string_literal: true

# == Schema Information
#
# Table name: movements
#
#  id            :bigint           not null, primary key
#  category_id   :bigint           not null
#  account_id    :bigint           not null
#  final_balance :integer
#  amount        :integer
#  comment       :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require('rails_helper')

RSpec.describe(Movement, type: :model) do
  context 'with attributes val' do
    it { is_expected.to(validate_presence_of(:final_balance)) }
    it { is_expected.to(validate_presence_of(:amount)) }
  end

  context 'when create movement' do
    it 'use valid data' do
      debt = build(:movement)
      expect(debt).to(be_valid)
    end

    it 'use invvalid data no amount' do
      debt = build(:movement, amount: nil)
      expect(debt).not_to(be_valid)
    end

    it 'use invvalid data no amount' do
      account = build(:account, account_type: 'common')
      account.save
      debt = account.movements.create()
      expect(debt).not_to(be_valid)
    end

    it 'match common account balance' do
      account = build(:account, account_type: 'common')
      category = build(:category)
      account.save
      category.save
      movement = account.movements.create(amount: 300, category: category)
      expect(movement.final_balance).to(match(account.balance_cents))
    end

    it 'match debt account balance' do
      account = build(:account, account_type: 'debt')
      category = build(:category)
      account.save
      category.save
      movement = account.movements.create(category: category)
      expect(movement).to(be_invalid)
    end

    it 'new debit balance cannot be negative' do
      account = build(:account, account_type: "debt", balance: 1, quota: 0)
      category = build(:category)
      account.save
      category.save
      movement = account.movements.create(amount: -2, category: category)
      expect(movement).to(be_invalid)
    end
  end
end
