class RemoveFechaFromMovement < ActiveRecord::Migration[6.0]
  def change
    remove_column :movements, :fecha, :timestamp
  end
end
