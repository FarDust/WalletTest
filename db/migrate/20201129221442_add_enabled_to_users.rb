class AddEnabledToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :enabled, :boolean, default: true
    add_column :users, :deleted, :boolean, default: false
  end
end
