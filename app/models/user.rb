# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string
#  role                   :string
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :debts_as_deudor,
           as: :deudor,
           dependent: :destroy,
           class_name: 'Debt'
  has_many :debts_as_acreedor,
           as: :acreedor,
           dependent: :destroy,
           class_name: 'Debt'
  has_many :accounts, dependent: :destroy
  has_many :transactions, dependent: :destroy

  def public_identifier
    "User ##{id} - Email:#{email} - Nombre:#{name}"
  end

  def can_be_destroyed?
    credit_balance.zero? && debt_balance.zero?
  end

  private

  def credit_balance
    accounts.credits.pluck(:balance_cents).compact.sum
  end

  def debt_balance
    debts_as_acreedor.pluck(:amount).compact.sum -
      debts_as_deudor.pluck(:amount).compact.sum
  end
end
