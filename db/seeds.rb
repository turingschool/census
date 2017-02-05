Doorkeeper::Application.create(name: "Monocle", redirect_uri: "http://localhost:3001/auth/census/callback", scopes: '')

User.destroy_all
Affiliation.destroy_all
Invitation.destroy_all
Cohort.destroy_all
Group.destroy_all
Role.destroy_all
UserRole.destroy_all

cohort_1608 = [
  "Joey Stansfield",
  "Ali Schlereth",
  "Brad Green"
]

["Turing Lab", "Pahlka", "Joan of Clarke"].each do |name|
  Group.find_or_create_by(name: name)
  p "Group #{name} has been created"
end

cohort = Cohort.create(name: "1608-BE")
Cohort.create(name: "1608-FE")
Cohort.create(name: "1610-BE")
Cohort.create(name: "1610-FE")

["applicant", "invited", "enrolled", "active student",
 "on leave", "graduated", "exited", "removed", "mentor", "admin"].each do |role|
   Role.find_or_create_by(name: role)
   p "Role #{Role.last.id} has been created with name #{Role.last.name}"
 end

active_student = Role.find_by(name: "active student")
admin = Role.find_by(name: "admin")
applicant = Role.find_by(name: "applicant")

cohort_1608.each do |person|
  first_name = person.split.first
  last_name = person.split.last

  user = User.new({
    first_name: first_name,
    last_name: last_name,
    cohort_id: cohort.id,
    email: "#{first_name.first.downcase}.#{last_name.first.downcase}@example.com",
    password: "password",
    confirmed_at: DateTime.new()
  })
  user.roles << active_student
  if user.save
    p "Added #{user.first_name} #{user.last_name} to the Users table."
  end
end

admin_user = User.new({
  first_name: "Ad",
  last_name: "Min",
  email: "admin@example.com",
  password: "password",
  confirmed_at: DateTime.new()
})
admin_user.roles << admin
admin_user.save

applicant_user = User.new({
  first_name: "Wanna",
  last_name: "Be",
  email: "wannabe@example.com",
  password: "password",
  confirmed_at: DateTime.new()
})
applicant_user.roles << applicant
applicant_user.save

accordian = User.new({
  first_name: "Accordian",
  last_name: "Player",
  email: "accordian@example.com",
  password: "password",
  confirmed_at: DateTime.new()
})
accordian.groups << Group.find_by(name: "Pahlka")
accordian.save
