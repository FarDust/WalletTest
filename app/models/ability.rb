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
        can(:manage, Account, user_id: user.id)
        can(:manage, NaturalPerson)
        can(:manage, Debt) do |debt|
          debt.acreedor_id == user.id || debt.deudor_id == user.id
        end
        movements_management(user)
      end
    end
  end

  def movements_management(user)
    action = user.enabled? ? :manage : :read
    if user.enabled?
      can(:manage, Transaction, user_id: user.id)
      can(:manage, Movement) do |movement|
        movement&.account&.user_id == user.id || movement.new_record?
      end
    else
      can(:read, Transaction, user_id: user.id)
      can(:read, Movement, account: { user_id: user.id })
    end
  end
end
# rubocop:enable Metrics/AbcSize
