require 'rails_helper'

RSpec.feature 'Invitations' do
  scenario 'are created when an admin user completes the invitation form' do
    admin = create :admin
    login(admin)

    visit new_invitation_path
    fill_in 'Emails', with: 'email1@example.com, email2@example.com'
    select 'mentor', from: 'role'
    click_button "Invite"

    expect(current_path).to eq(admin_dashboard_path)
    expect(page).to have_content('Your emails are being sent. You will receive a confirmation once this process is complete.')
  end
end
