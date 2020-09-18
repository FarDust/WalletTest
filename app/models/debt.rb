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
class Debt < ApplicationRecord
  belongs_to :acreedor, polymorphic: true
  belongs_to :deudor, polymorphic: true
end
