require "rails_helper"

RSpec.feature "admin manages user groups" do
  before :each do
    @groups = create_list(:group, 3)
    admin = create :admin
    sign_in admin
  end

  context "admin visits admin dashboard" do
    it "links to group index" do
      visit admin_dashboard_path
      click_on "Manage Groups"

      expect(current_path).to eq(admin_groups_path)
    end
  end

  context "admin visits group index" do
    it "displays all groups" do
      visit admin_groups_path

      @groups.each do |group|
        expect(page).to have_content(group.name)
        within(".#{group.name}") do
          expect(page).to have_content("#{group.users.count}")
        end
      end
    end
  end

end
