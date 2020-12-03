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
        can(:manage, Transaction, user_id: user.id)
        can(:manage, Movement)
        can(:manage, NaturalPerson)
        can(:manage, Debt, acreedor_id: user.id)
        can(:manage, Debt, deudor_id: user.id) # podría restringirse
        can(:read, Category)
      end
    end
  end
end
