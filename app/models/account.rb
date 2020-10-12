# frozen_string_literal: true

# == Schema Information
#
# Table name: accounts
#
#  id           :bigint           not null, primary key
#  user_id      :bigint           not null
#  balance      :integer
#  account_type :string
#  currency     :string
#  quota        :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Account < ApplicationRecord

  register_currency :clp

  belongs_to :user
  validates :balance_cents, presence: true
  validates :account_type, presence: true
  
  monetize :balance_cents, with_model_currency: :balance_currency
end
