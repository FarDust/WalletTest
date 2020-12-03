class AddRelatedAccountToNaturalPeople < ActiveRecord::Migration[6.0]
  def change
    add_column :natural_people, :related_account, :bigint
  end
end
