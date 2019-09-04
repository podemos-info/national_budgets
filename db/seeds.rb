# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
if Rails.env.development? 
  User.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') unless User.find_by(email:'admin@example.com')
  Budget.create!(title: 'PRESUPUESTOS GENERALES DEL ESTADO 2018', date: '2019/04/09', user_id: 1) unless Budget.find_by(title:'PRESUPUESTOS GENERALES DEL ESTADO 2018')
  Budget.create!(title: 'PRESUPUESTOS GENERALES DEL ESTADO 2019', date: '2019/01/16', user_id: 1) unless Budget.find_by(title:'PRESUPUESTOS GENERALES DEL ESTADO 2019')
end