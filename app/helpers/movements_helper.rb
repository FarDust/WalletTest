# frozen_string_literal: false

module MovementsHelper
  def get_relevant_movements(user)
    Movement.includes(:account)
            .where('accounts.user' => user)
            .references(:account)
            .order('movements.created_at desc')
            .last(10)
  end

  def get_destination(movement)
    transaction =
      Transaction.where(origin_movement: movement).first ||
      Transaction.where(target_movement: movement).first
    return movement if transaction.nil?

    if transaction.origin_movement == movement
      transaction.target_movement
    else
      transaction.origin_movement
    end
  end
end
