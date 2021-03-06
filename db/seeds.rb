# frozen_string_literal: true

require 'faker'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Category.create!(
#   [
#     { name: 'Business', description: '' },
#     { name: 'Charity', description: '' },
#     { name: 'Debts', description: '' },
#     { name: 'Education', description: '' },
#     { name: 'Enterteinment', description: '' },
#     { name: 'Health', description: '' },
#     { name: 'Incomes', description: '' },
#     { name: 'Restaurants', description: '' },
#     { name: 'Subcriptions', description: '' },
#     { name: 'Travels', description: '' },
#     { name: 'Others', description: '' }
#   ]
# )

# Quitar comentarios solo si importa. Por ahora es innecesario
# NaturalPerson.create!(
#  [
#    { nombre: 'Persona Natural', apellido: 'Numero 1', rut:'12882394-8'}
#  ]
# )

# User.create(email: 'admin@test.cl', password: 'test123', admin: true)
# for i in (1..10)
#   User.create(email: Faker::Internet.email, password: "test123")
# end
categories = Category.all.pluck(:id)
for u in User.all.each do
  r = Random.new
  acc = u.accounts.last
  next if acc.nil?

  for j in (1..r.rand(500..1500))
    category_id = categories.sample
    acc.movements
       .create(category_id: category_id, amount: r.rand(-1000..1000))
  end
end
# Account.all.each do |acc|
#   category = Category.order('RANDOM()').first
#   other = Account.where.not(id: acc.id).order('RANDOM()').first
#   amount = Random.new.rand(-1000..10000)
#   origin = acc.movements.create(category: category, amount: amount, comment: "test")
#   destiny = other.movements.create(category: category, amount: -amount, comment: "test")
#   acc.user.transactions.create(origin_movement: origin, target_movement: destiny)
# end
