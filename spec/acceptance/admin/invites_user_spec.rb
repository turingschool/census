require 'rails_helper'

RSpec.feature 'Invitations' do
  scenario 'are created when an admin user completes the invitation form' do
    create :role, name: "mentor"
    admin = create :admin
    other_invitation = create :invitation, user: admin, created_at: Time.current - 6.minutes
    login(admin)
    
    click_link 'Inivte Users'
    expect(current_path).to eq(new_invitation_path)

    fill_in 'Emails', with: 'email1@example.com, email2@example.com'
    select 'mentor', from: 'role'
    click_button "Invite"

    expect(current_path).to eq(invitations_path)
    expect(page).to have_content('Your emails are being sent. You will receive a confirmation once this process is complete.')
    expect(page).to have_content('email1@example.com')
    expect(page).to have_content('email2@example.com')
    expect(page).to have_content('mailed', count: 2)
    expect(page).to have_content('less than a minute', count: 2)
    expect(page).to_not have_content(other_invitation.email)
  end
end
