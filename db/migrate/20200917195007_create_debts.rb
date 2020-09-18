class CreateDebts < ActiveRecord::Migration[6.0]
  def change
    create_table :debts do |t|
      t.integer :interest
      t.integer :amount
      t.references :acreedor, polymorphic: true, null: false
      t.references :deudor, polymorphic: true, null: false

      t.timestamps
    end
  end
end
