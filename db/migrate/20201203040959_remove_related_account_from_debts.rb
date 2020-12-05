class RemoveRelatedAccountFromDebts < ActiveRecord::Migration[6.0]
  def change
    remove_column :debts, :related_account, :bigint
  end
end
