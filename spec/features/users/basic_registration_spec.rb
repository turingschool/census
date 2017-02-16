require 'rails_helper'

RSpec.feature 'User signs up' do
  scenario 'by completing minimum registration' do
    role = create :role, name: 'admin'
    invite = create :invitation, role: role

    visit invite.generate_url(new_user_registration_url)

    fill_in 'First Name*', with: 'Jeff'
    fill_in 'Last Name*', with: 'Casimir'
    fill_in 'Password*', with: 'password'
    fill_in 'Password Confirmation*', with: 'password'
    click_button 'Sign up'

    help_message = 'You have succesfully signed up!'

    expect(page).to have_content(help_message)
    expect(User.count).to eq(1)
    expect(User.last.first_name).to eq('Jeff')
    expect(User.last.last_name).to eq('Casimir')
  end

  scenario 'and does not fill in first name' do
    role = create :role, name: 'Staff'
    invite = create :invitation, role: role

    visit invite.generate_url(new_user_registration_url)

    fill_in 'Last Name*', with: 'Casimir'
    fill_in 'Password*', with: 'password'
    fill_in 'Password Confirmation*', with: 'password'
    click_button 'Sign up'

    error_message = "First name can't be blank"

    expect(page).to have_content(error_message)
    expect(User.count).to eq(0)
  end
end
