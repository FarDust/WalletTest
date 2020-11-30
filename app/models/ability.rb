# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.present?
      if user.admin?
        can(:manage, :all)
      else
        can(:manage, Account, user_id: user.id)
        can(:manage, NaturalPerson)
        can(:manage, Debt)
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
