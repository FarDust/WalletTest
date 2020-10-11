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
  belongs_to :user
  validates :balance_cents, presence: true
  validates :account_type, presence: true
  validate :credit_does_not_have_positive_balance
  monetize :balance_cents

  def credit_does_not_have_positive_balance
    if account_type == "credit" && balance > 0
      errors.add(:positive_credit, 'A credit account cannot have a positve balance.')
    end
  end
end
