# As a logged in admin
# When I visit the invite dashboard
# Then I see a link to bulk invite users
# And I see a list of pending invitations
# And each invite has an option to resend
# And each invite has an option to cancel
require 'rails_helper'

RSpec.feature "Admin dashboard" do
  it "displays invitation content" do
    admin = create :admin
    invitations = create_list :invitations, 2

    visit admin_dashboard_path

    expect(page).to have_link("Invite People")
    expect(page).to have_content("Pending Invitations")
    within "#pending-invitations" do
      expect(page).to have_css("tr", count: 3)
      expect(page).to have_link("resend", count: 3)
      expect(page).to have_link("cancel", count: 3)
    end
  end
end
