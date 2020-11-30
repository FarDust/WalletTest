# frozen_string_literal: true

module MovementsHelper
  def get_relevant_movements(user)
    Movement.includes(:account).where("accounts.user" => user).references(:account).order("movements.created_at desc").last(10)
  end

  def get_destination(movement)
    result = "stupid"
    movement.transaction.each do |transaction|
      if !transaction.nil?
        raise
      end
    end
    # Movement.where(id: transaction.target_movement_id)
  end
end
