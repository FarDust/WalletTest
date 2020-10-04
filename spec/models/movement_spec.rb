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
end
