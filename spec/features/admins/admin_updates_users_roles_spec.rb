require "rails_helper"

RSpec.describe "Admin updates users' roles" do
  context "they visit admin/roles/users" do
    it "displays a form for updating users" do
      role_1, role_2, role_3 = create_list(:role, 3)
      admin = create :admin
      users = create_list(:user, 3)
      users.first.roles << role_1
      users.second.roles << role_1
      users.second.roles << role_2

      login admin
      visit admin_roles_users_edit_path

      expect(page).to have_content("Find")
      expect(page).to have_css('#searchBox')
      expect(page).to have_content("Add Role(s)")
      expect(page).to have_content(role_1.name)
      expect(page).to have_content(role_2.name)
      expect(page).to have_content(role_3.name)
      expect(page).to have_button('Save')
    end
  end
end
