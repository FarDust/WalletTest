# frozen_string_literal: false

require('rails_helper')

RSpec.describe(User, type: :model) do
  context 'creating user' do
    it 'does create the user' do
      user = User.new(email: 'test@test.cl', password: '123456')
      expect(user.save).to eq(true)
    end

    it 'doesnt create the user for mail validation' do
      user = User.new(email: 'test', password: '123456')
      expect(user.save).to eq(false)
    end

    it 'doesnt create the user for password length validation' do
      user = User.new(email: 'test@test.cl', password: '123')
      expect(user.save).to eq(false)
    end
  end
end
