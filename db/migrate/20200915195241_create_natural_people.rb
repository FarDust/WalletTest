class CreateNaturalPeople < ActiveRecord::Migration[6.0]
  def change
    create_table :natural_people do |t|
      t.string :nombre
      t.string :apellido
      t.string :rut

      t.timestamps
    end
  end
end
