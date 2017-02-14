Doorkeeper::Application.create(name: "Monocle", redirect_uri: "http://localhost:3001/auth/census/callback", scopes: '')

Invitation.destroy_all
User.destroy_all
Affiliation.destroy_all
Cohort.destroy_all
Group.destroy_all
Role.destroy_all
UserRole.destroy_all

cohort = Cohort.create(name: "1608-BE")
Cohort.create(name: "1608-FE")
Cohort.create(name: "1610-BE")
Cohort.create(name: "1610-FE")
Cohort.create(name: "1611-BE")
Cohort.create(name: "1611-FE")
Cohort.create(name: "1701-BE")
Cohort.create(name: "1701-FE")

["enrolled", "active student", "graduated", "exited", "removed", "mentor", "admin", "staff", "instructor"].each do |role|
   Role.find_or_create_by(name: role)
   p "Role #{Role.last.id} has been created with name #{Role.last.name}"
 end

active_student = Role.find_by(name: "active student")
admin = Role.find_by(name: "admin")

user = User.new({
  first_name: "Joey",
  last_name: "Stansfield",
  cohort_id: cohort.id,
  email: "joseph.r.stansfield@gmail.com",
  password: "password",
  confirmed_at: DateTime.new()
})
user.roles << active_student
user.roles << admin
if user.save
  p "Added #{user.first_name} #{user.last_name} to the Users table."
end
