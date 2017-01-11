require 'rails_helper'

RSpec.feature 'User signs up' do
  scenario 'by completing full registration' do
    user = attributes_for(:user)
    role = create :role, name: 'Enrolled'
    invite = create :invitation, role: role

    visit invite.generate_url(new_user_registration_url)

    fill_in 'First name', with: user[:first_name]
    fill_in 'Last name', with: user[:last_name]
    fill_in 'Password', with: user[:password]
    fill_in 'Password confirmation', with: user[:password]
    fill_in 'user[twitter]', with: user[:twitter]
    fill_in 'user[linked_in]', with: user[:linked_in]
    fill_in 'GitHub', with: user[:git_hub]
    fill_in 'Slack', with: user[:slack]
    find("option[value='1606']").select_option
    find("#armstrong").click

    click_button 'Sign up'

    help_message = 'You have succesfully signed up! Please log in to continue.'
    expect(page).to have_content(help_message)
  end
end
