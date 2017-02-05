require "rails_helper"

RSpec.feature "admin manages user roles" do
  before :each do
    @roles = create_list(:role, 3)
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

      @roles.each do |role|
        expect(page).to have_content(role.name)
        within(".#{role.name}") do
          expect(page).to have_content("#{role.users.count}")
        end
      end
    end
  end

end 
