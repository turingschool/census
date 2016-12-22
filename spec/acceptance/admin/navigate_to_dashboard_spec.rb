require 'rails_helper'

RSpec.feature "Admin" do
  it "can get to dashboard after login" do
    admin = create :admin

    login(admin)
    click_link "Go to Dashboard"

    expect(page).to have_link("Invite People")
    expect(page).to have_content("Pending Invitations")
  end
end
