require 'rails_helper'

RSpec.feature 'User signs up' do
  scenario 'by completing full registration' do
    cohort = create :cohort
    user = attributes_for(:user)
    role = create :role, name: 'active student'
    invite = create :invitation, role: role

    visit invite.generate_url(new_user_registration_url)

    fill_in 'First Name*', with: user[:first_name]
    fill_in 'Last Name*', with: user[:last_name]
    fill_in 'Password*', with: user[:password]
    fill_in 'Password Confirmation*', with: user[:password]
    fill_in 'user[twitter]', with: user[:twitter]
    fill_in 'user[linked_in]', with: user[:linked_in]
    fill_in 'user[git_hub]', with: user[:git_hub]
    fill_in 'user[slack]', with: user[:slack]
    fill_in 'user[stackoverflow]', with: user[:stackoverflow]

    find("option[value='#{cohort.id}']").select_option

    click_button 'Sign up'

    help_message = 'You have succesfully signed up!'
    expect(page).to have_content(help_message)
  end
end
