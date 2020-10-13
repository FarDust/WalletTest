class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.references :user, null: false, foreign_key: true
      t.monetize :balance
      t.string :account_type
      t.integer :quota

      t.timestamps
    end
  end
end
