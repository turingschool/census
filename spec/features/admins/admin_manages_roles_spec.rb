require "rails_helper"

RSpec.feature "admin manages user roles" do
  before :each do
    @role1, @role2, @role3 = create_list(:role, 3)
    admin = create :admin
    sign_in admin
  end
  context "admin visits admin dashboard" do
    it "links to role index" do
      visit admin_dashboard_path
      click_on "Manage Roles"

      expect(current_path).to eq(admin_roles_path)
    end
  end

  context "admin visits role index" do
    it "displays all roles" do
      visit admin_roles_path

      expect(page).to have_content(@role1.name)
      expect(page).to have_content(@role2.name)
      expect(page).to have_content(@role3.name)
    end
  end
end
