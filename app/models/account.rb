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
  has_many :movements, dependent: :destroy

  COMMON_TYPE = 'common'
  DEBT_TYPE = 'debt'
  CREDIT_TYPE = 'credit'

  TYPES = {
    COMMON_TYPE => 'Corriente',
    DEBT_TYPE => 'Débito',
    CREDIT_TYPE => 'Crédito'
  }.freeze

  def can_transact?(amount)
    send("#{account_type}_transact", amount)
  end

  def transaction_type_error
    case account_type
    when DEBT_TYPE
      'Error de validación por cuenta débito'
    when CREDIT_TYPE
      'Credit account cannot have a positive balance after a transaction.'
    else
      'Monto no corresponde'
    end
  end

  def credit_does_not_have_positive_balance
    if account_type == CREDIT_TYPE && balance > 0
      errors.add(:positive_credit, 'A credit account cannot have a positive balance.')
    end
  end

  private

  # Como una cuenta corriente puede tener saldo positivo o negativo,
  # no necesita validacion
  def common_transact(amount)
    !amount.nil?
  end

  # Aca la logica de validar una transaccion para cuenta debito
  def debt_transact(amount)
    !amount.nil?
  end

  # A credit card cannot have a positive balance. 
  def credit_transact(amount)
    # TODO: Replace 'CLP' with actual currency.
    !amount.nil? && !(balance + Money.new(amount, 'CLP') > 0)
  end
end
