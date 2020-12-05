# frozen_string_literal: true

# == Schema Information
#
# Table name: natural_people
#
#  id         :bigint           not null, primary key
#  nombre     :string
#  apellido   :string
#  related_account    :bigint     # OJO que pudo salir mal
#########  rut        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class NaturalPerson < ApplicationRecord
  validates :nombre, presence: true
  validates :apellido, presence: true
  # validates :rut, presence: true

  has_many :debts, as: :deudor, dependent: :restrict_with_error
  has_many :debts, as: :acreedor, dependent: :restrict_with_error

  def public_identifier
    "NP ##{id} - Nombre:#{nombre} - Apellido:#{apellido}"
  end
end
