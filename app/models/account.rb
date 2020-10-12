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
  monetize :balance_cents
  has_many :movements

  COMMON_TYPE = "common"
  DEBT_TYPE = "debt"
  CREDIT_TYPE = "credit"

  TYPES = {
    COMMON_TYPE => "Corriente",
    DEBT_TYPE => "Débito",
    CREDIT_TYPE => "Crédito"
  }

  def can_transact?(amount)
    send("#{account_type}_transact", amount)
  end

  def update_balance(amount)
    update(quota: 2)
  end

  def transaction_type_error
    case account_type
    when DEBT_TYPE
      "Error de validación por cuenta débito"
    when CREDIT_TYPE
      "Error de validación por cuenta crédito"
    else
      "Monto no corresponde"
    end
  end

  private

  def common_transact(amount)
    # Como una cuenta corriente puede tener saldo positivo o negativo,
    # no necesita validación
    true
  end

  def debt_transact(amount)
    # Acá la lógica de validar una transacción para cuenta débito
  end

  def credit_transact(amount)
    # Acá la lógica de validar una transacción para cuenta crédito
  end
end
