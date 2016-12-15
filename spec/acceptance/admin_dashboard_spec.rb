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
    create :invitation, email: "you@example.com"
    create :invitation

    login(admin)
    visit admin_dashboard_path

    expect(page).to have_link("Invite People")
    expect(page).to have_content("Pending Invitations")
    within "#pending-invitations" do
      expect(page).to have_css("tr", count: 3)
      expect(page).to have_link("Resend", count: 2)
      expect(page).to have_link("Cancel", count: 2)
      expect(page).to have_content(Invitation.first.email)
      expect(page).to have_content(Invitation.first.created_at.to_date)
      expect(page).to have_content(Invitation.last.email)
      expect(page).to have_content(Invitation.last.created_at.to_date)
    end
  end
end
