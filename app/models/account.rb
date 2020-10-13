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

  valid_account_types = ["Current", "Debit", "Credit"].to_set()

  def self.update(params)
    if self.account_type == "Current" && params[:quota]
      raise "Current accounts dosen't have any quota"
    end
    super.save(params)
  end

  def self.save
    if !(valid_account_types.include?(params.account_type))
      raise "Must be type" + valid_account_types.map(&:inspect).join(' or ')
    end
    super.save
  end

end
