# As a logged in admin user
# When I visit the new invite form
# And I type a comma separated list of email addresses into the form
# And I select "Mentor" from the group dropdown select
# And I click "Invite"
# Then I see a confirmation message that says "Your emails are being sent. You will receive a confirmation once this process is complete."
# And I am redirected to the admin dashboard page

require 'rails_helper'

RSpec.feature 'Invitations' do
  scenario 'are created when an admin user completes the invitation form' do
    admin = create :admin
    login(admin)

    visit new_invitation_path
    fill_in 'Emails', with: 'email1@example.com, email2@example.com'
    select 'mentor', from: 'group'
    # find('#group-select').find("option[value='mentor']").select_option
    click_button "Invite"

    expect(current_path).to eq(admin_dashboard_path)
    expect(page).to have_content('Your emails are being sent. You will receive a confirmation once this process is complete.')
  end
end
