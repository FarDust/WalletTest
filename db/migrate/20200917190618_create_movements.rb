class CreateMovements < ActiveRecord::Migration[6.0]
  def change
    create_table :movements do |t|
      t.references :category, null: false, foreign_key: true
      t.references :account, null: false, foreign_key: true
      t.timestamp :fecha
      t.integer :final_balance
      t.integer :amount
      t.text :comment

      t.timestamps
    end
  end
end
