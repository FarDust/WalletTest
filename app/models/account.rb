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
  validate :debit_account_is_valid
  validate :credit_account_is_valid
  monetize :balance_cents, with_model_currency: :balance_currency
  has_many :movements, dependent: :destroy

  before_save :types_guard
  before_save :debt_guard
  after_update :debt_guard

  VALID_TYPES = %w[common debt credit].to_set()

  COMMON_TYPE = 'common'
  DEBT_TYPE = 'debt'
  CREDIT_TYPE = 'credit'

  TYPES = {
    COMMON_TYPE => 'Common',
    DEBT_TYPE => 'Debit',
    CREDIT_TYPE => 'Credit'
  }.freeze

  def debt_guard
    if account_type == DEBT_TYPE && quota != 0
      errors[:base] << "debt accounts dosen't have any quota"
      quota = 0
      return false
    end
    true
  end

  def types_guard
    if VALID_TYPES.exclude?(account_type)
      error = "Must be type #{VALID_TYPES.map(&:inspect).join(' or ')} "
      error += "and we get #{account_type}"
      errors[:base] << error
      return false
    end
    true
  end

  def can_transact?(amount)
    send("#{account_type}_transact", amount)
  end

  def transaction_type_error
    case account_type
    when DEBT_TYPE
      'A debt account cannot have a negative balance.'
    when CREDIT_TYPE
      'Credit account cannot have a positive balance after'\
      ' a transaction nor exceed quota.'
    else
      'Monto no corresponde'
    end
  end

  def name
    "##{id} - #{account_type}"
  end

  def personal_account_identifier
    "##{id} - #{account_type} (#{balance_cents} #{balance_currency})"
  end

  def public_account_identifier
    "#{user.email} - ##{id} - #{account_type} (#{balance_currency})"
  end

  private

  def credit_account_is_valid
    if account_type == CREDIT_TYPE
      if balance.positive?
        errors.add(
          :positive_credit,
          'A credit account cannot have a positive balance.'
        )
      end
      if balance.amount.abs > quota
        errors.add(
          :exceeds_quota,
          'The balance exceeds the defined quota.'
        )
      end
    end
  end

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
          transaction_type_error
        )
      end
    end
  end

  # A credit card cannot have a positive balance.
  def credit_transact(amount)
    new_balance_amount = (balance + Money.new(amount, balance.currency)).amount
    !amount.nil? && !new_balance_amount.positive? &&
      new_balance_amount.abs <= quota
  end
end
