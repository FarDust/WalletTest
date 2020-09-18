# frozen_string_literal: true

# == Schema Information
#
# Table name: natural_people
#
#  id         :bigint           not null, primary key
#  nombre     :string
#  apellido   :string
#  rut        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class NaturalPerson < ApplicationRecord
  has_many :debts, as: :deudor, dependent: :destroy
  has_many :debts, as: :acreedor, dependent: :destroy
end
