class AddRelatedAccountToDebts < ActiveRecord::Migration[6.0]
  def change
    add_column :debts, :related_account, :bigint
  end
end
