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
  validate :debit_account_is_valid
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
      'Error de validación por cuenta crédito'
    else
      'Monto no corresponde'
    end
  end

  private

  # Como una cuenta corriente puede tener saldo positivo o negativo,
  # no necesita validacion
  def common_transact(amount)
    !amount.nil?
  end

  # Como una cuenta corriente solo puede tener saldo positivos o 0
  # se requiere REVISAR
  def debt_transact(amount)
    new_balance_amount = (balance + Money.new(amount, balance.currency)).amount
    !amount.nil? && new_balance_amount >= 0
  end

  # Robado del commit del Alonso. Valida que la cuenta de debito cumpla
  # con no tener balance negativo
  def debit_account_is_valid
    if account_type == DEBT_TYPE
      if balance.negative?
        errors.add(
          :negative_balance,
          'A credit account cannot have a negative balance.'
        )
      end
    end
  end

  # Aca la logica de validar una transaccion para cuenta credito
  def credit_transact(amount)
    !amount.nil?
  end
end
