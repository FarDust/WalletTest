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
    it { is_expected.to(validate_presence_of(:balance)) }
    it { is_expected.to(validate_presence_of(:type)) }
    it { is_expected.to(validate_presence_of(:currency)) }
  end

  context 'with associations val' do
    it { is_expected.to(belong_to(:user).required) }
  end

  context 'when create account' do
    it 'use valid data' do
      account = build(:account)
      expect(account).to(be_valid)
    end
    # falta generar validor para que otros tipos de cuentan no tengan balance negativo
  end
end
