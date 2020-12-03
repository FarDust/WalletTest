class AddCurrencyToDebts < ActiveRecord::Migration[6.0]
  def change
    add_column :debts, :currency, :string, default: 'CLP', null: false
  end
end
