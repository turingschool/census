require 'rails_helper'

RSpec.feature "Invitation is malformed" do
  it "displays a useful error if bad emails are input" do
    create :role, name: "mentor"
    admin = create :admin
    sign_in admin
    visit new_invitation_path

    fill_in "Emails", with: "bad_email, good@example.com, bad_example.com"
    select 'Mentor', from: 'role'

    click_button "Invite"

    expect(current_path).to eq(new_invitation_path)
    expect(page).to have_content("1 out of 3 invites sent. Error sending bad_email, bad_example.com.")
  end
end
