# frozen_string_literal: true

# es la config del cancan, no deberia estar tan regulado
# rubocop:disable Metrics/AbcSize

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.present?
      if user.admin?
        can(:manage, :all)
      else
        can(:manage, User, id: user.id)
        can(:manage, Account, user_id: user.id)
        can(:manage, Transaction, user_id: user.id)
        can(:manage, Movement)
        can(:manage, NaturalPerson)
        can(:manage, Debt, acreedor_id: user.id)
        can(:manage, Debt, deudor_id: user.id) # podria restringirse
        can(:read, Category)
      end
    end
  end
end
# rubocop:enable Metrics/AbcSize
