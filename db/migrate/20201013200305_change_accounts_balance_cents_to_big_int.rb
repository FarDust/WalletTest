class ChangeAccountsBalanceCentsToBigInt < ActiveRecord::Migration[6.0]
  def change
    change_column :accounts, :balance_cents, :bigint
  end
end
