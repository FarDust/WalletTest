class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.integer :origin_movement_id
      t.integer :target_movement_id

      t.timestamps
    end
  end
end
