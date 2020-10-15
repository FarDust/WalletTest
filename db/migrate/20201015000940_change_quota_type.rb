class ChangeQuotaType < ActiveRecord::Migration[6.0]
  def change
    change_column :accounts, :quota, :bigint
  end
end
