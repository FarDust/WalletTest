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

# Deshabilitamos esta regla para poder hacer tests con @variable.
# rubocop:disable RSpec/InstanceVariable

RSpec.describe(Movement, type: :model) do
  context 'when create movement, watch data validness' do
    let(:category) { FactoryBot.create(:category) }
    let(:common_acc) { FactoryBot.create(:account, account_type: 'common') }

    it 'use valid data' do
      debt = build(:movement)
      expect(debt).to(be_valid)
    end

    it 'use invalid data no amount' do
      debt = build(:movement, amount: nil)
      expect(debt).not_to(be_valid)
    end

    it 'use invalid data empty' do
      debt = common_acc.movements.create()
      expect(debt).not_to(be_valid)
    end
  end

  context 'when create movements, watch match balance' do
    let(:category) { FactoryBot.create(:category) }
    let(:common_acc) { FactoryBot.create(:account, account_type: 'common') }
   
    it 'match common balance' do
      movement = common_acc.movements.create(amount: 300, category: category)
      expect(movement.final_balance).to(match(common_acc.balance_cents))
    end

    # REVISAR continuidad
    it 'match debt balance' do
      account = create(:account, account_type: 'debt')
      movement = account.movements.create(category: category)
      expect(movement).to(be_invalid)
    end
  end

  context 'when create movements, watch balance sign & quota' do
    let(:category) { FactoryBot.create(:category) }
    let(:common_acc) { FactoryBot.create(:account, account_type: 'common') }

    it 'new debit balance cannot be negative' do
      account = create(:account, account_type: 'debt', balance: 1, quota: 0)
      category = create(:category)
      movement = account.movements.create(amount: -2, category: category)
      expect(movement).to(be_invalid)
    end

    it 'new credit balance cannot be positve' do
      account = create(:account, account_type: 'credit', balance: -1, quota: 1)
      category = create(:category)
      movement = account.movements.create(amount: 2, category: category)
      expect(movement).to(be_invalid)
    end

    it 'new credit balance cannot exceed quota' do
      account = create(:account, account_type: 'credit', balance: -1, quota: 1)
      category = create(:category)
      movement = account.movements.create(amount: -1, category: category)
      expect(movement).to(be_invalid)
    end
  end
end
# rubocop:enable RSpec/InstanceVariable