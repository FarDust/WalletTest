# frozen_string_literal: false

require('rails_helper')

RSpec.describe(Users, type: :model) do
  context 'when creating user' do
    it 'use correct params' do
      user = User.new(email: 'test@test.cl', password: '123456')
      expect(user.save).to(eq(true))
    end

    it 'use invalid email' do
      user = User.new(email: 'test', password: '123456')
      expect(user.save).to(eq(false))
    end

    it 'use short password' do
      user = User.new(email: 'test@test.cl', password: '123')
      expect(user.save).to(eq(false))
    end
  end

  # disable
  context 'when deleting user' do
    it 'doesnt have debts' do
      user = create(:user)
      acc = create(:credit_account, balance: -100, quota: 200, user: user)
      create(:movement, account: acc, amount: 100)
      expect(user.can_be_destroyed?).to(eq(true))
    end
  end
end
