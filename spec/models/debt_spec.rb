# frozen_string_literal: true

# == Schema Information
#
# Table name: debts
#
#  id            :bigint           not null, primary key
#  interest      :integer
#  amount        :integer
#  acreedor_type :string           not null
#  acreedor_id   :bigint           not null
#  deudor_type   :string           not null
#  deudor_id     :bigint           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require('rails_helper')

RSpec.describe(Debt, type: :model) do
  context 'with attributes val' do
    it { is_expected.to(validate_presence_of(:amount)) }
  end
end
