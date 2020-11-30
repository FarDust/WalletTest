# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.present?
      if user.admin?
        can(:manage, :all)
      else
        can(:manage, User, id: user.id)
        can(:manage, Account, user_id: user.id)
        can(:manage, NaturalPerson)
        can(:manage, Debt)
        movements_management(user)
      end
    end
  end

  def movements_management(user)
    puts user.enabled?
    if user.enabled?
      can(:manage, Transaction, user_id: user.id)
      can(:manage, Movement)
    else
      can(:read, Transaction, user_id: user.id)
      can(:read, Movement, user_id: user.id)
    end
  end
end
