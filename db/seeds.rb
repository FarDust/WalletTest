# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Category.create!(
  [
    { name: 'Business', description: '' },
    { name: 'Charity', description: '' },
    { name: 'Debts', description: '' },
    { name: 'Education', description: '' },
    { name: 'Enterteinment', description: '' },
    { name: 'Health', description: '' },
    { name: 'Incomes', description: '' },
    { name: 'Restaurants', description: '' },
    { name: 'Subcriptions', description: '' },
    { name: 'Travels', description: '' },
    { name: 'Others', description: '' }
  ]
)

NaturalPerson.create!(
  [
    { nombre: 'Persona Natural', apellido: 'Numero 1', rut:'12882394-8'}
  ]
)