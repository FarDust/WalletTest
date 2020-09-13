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
end
