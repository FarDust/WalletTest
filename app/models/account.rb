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

  valid_account_types = %w[Current Debit Credit].to_set()
  
  has_many :movements, dependent: :destroy

  COMMON_TYPE = 'common'
  DEBT_TYPE = 'debt'
  CREDIT_TYPE = 'credit'

  TYPES = {
    COMMON_TYPE => 'Corriente',
    DEBT_TYPE => 'Débito',
    CREDIT_TYPE => 'Crédito'
  }.freeze

  def self.update(params)
    if account_type == 'Current' && params[:quota]
      raise("Current accounts dosen't have any quota")
    end

    super.save(params)
  end

  def self.save
    if valid_account_types.exclude?(params.account_type)
      raise('Must be type' + valid_account_types.map(&:inspect).join(' or ')) # rubocop:disable Style/StringConcatenation
    end

    super.save
  end

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

  # Aca la logica de validar una transaccion para cuenta debito
  def debt_transact(amount)
    !amount.nil?
  end

  # Aca la logica de validar una transaccion para cuenta credito
  def credit_transact(amount)
    !amount.nil?
  end
end
