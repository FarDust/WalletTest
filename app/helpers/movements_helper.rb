# frozen_string_literal: true

module MovementsHelper
  def get_relevant_movements(user)
    Movement.includes(:account).where("accounts.user" => user).references(:account).order("movements.created_at desc").last(10)
  end

  def get_destination(movement)
    transaction = Transaction.where(origin_movement: movement).first || Transaction.where(target_movement: movement).first
    if transaction.nil?
      return movement
    end
    transaction.origin_movement == movement ? transaction.target_movement : transaction.origin_movement
  end
end
