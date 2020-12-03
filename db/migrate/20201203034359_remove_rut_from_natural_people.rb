class RemoveRutFromNaturalPeople < ActiveRecord::Migration[6.0]
  def change
    remove_column :natural_people, :rut, :string
  end
end
