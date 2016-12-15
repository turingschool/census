# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Doorkeeper::Application.create(name: "Monocle", redirect_uri: "http://localhost:3001/auth/census/callback", scopes: '')

User.create(first_name: "C", last_name: "Calaway", email: "c@calaway.cc", password: "password1", confirmed_at: DateTime.new())

# Create some roles
["applicant", "invited", "enrolled", "active student",
 "on leave", "graduated", "exited", "removed", "mentor"].each do |role|
   print "Creating role: '#{role}'... "
   Role.find_or_create_by(name: role)
   print "Role #{Role.last.id} has been created with name '#{Role.last.name}'\n\n"
 end
