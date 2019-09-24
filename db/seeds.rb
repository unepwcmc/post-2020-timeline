# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

secrets = Rails.application.secrets

user = User.where(email: secrets.admin[:admin_email]).first_or_create do |u|
  u.password              = secrets.admin[:admin_password]
  u.password_confirmation = secrets.admin[:admin_password]

  puts "Admin created! \nU: #{secrets.admin[:admin_email]}\nP: #{secrets.admin[:admin_password]}"
end