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
class Movement < ApplicationRecord
  belongs_to :category
  belongs_to :account
  validates :amount, presence: true
  validates :final_balance, presence: true
  validates :amount, numericality: { other_than: 0 }
  before_validation :set_final_balance
  after_create :set_account_balance

  private

  def set_final_balance
    if account&.can_transact?(amount) && amount
      self.final_balance = amount + account&.balance_cents
      return
    end
    errors.add(:amount, account&.transaction_type_error)
  end

  def set_account_balance
    account.update(balance: final_balance)
  end
end
