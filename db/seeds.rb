# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Doorkeeper::Application.create(name: "Monocle", redirect_uri: "http://localhost:3001/auth/census/callback", scopes: '')

cohort_1606 = [
  "Dan Broadbent",
  "Ryan Workman",
  "C Calaway",
  "Brian Heim",
  "Brendan Dillon",
  "Bryan Goss",
  "Jasmin Hudacsek",
  "Susi Irwin",
  "Nate Anderson",
  "David Davydov",
  "Raphael Barbo",
  "Jesse Spevack",
  "Sonia Gupta",
  "Jean Joeris"
]

cohort_1606.each do |person|
  User.create({
    first_name: person.split.first,
    last_name: person.split.last,
    email: "#{first_name}.#{last_name}@example.com",
    image: "https://robohash.org/#{first_name}#{last_name}",
    password: "password1",
    confirmed_at: DateTime.new()
  })
end
