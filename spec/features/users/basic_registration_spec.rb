require 'rails_helper'

RSpec.feature 'User signs up' do
  scenario 'by completing minimum registration' do
    role = create :role, name: 'Staff'
    invite = create :invitation, role: role

    visit invite.generate_url(new_user_registration_url)

    fill_in 'First name', with: 'Jeff'
    fill_in 'Last name', with: 'Casimir'
    fill_in 'Email', with: ENV['MY_EMAIL']
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'

    save_and_open_page

    help_message = 'A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.'

    expect(page).to have_content(help_message)
    expect(User.count).to eq(1)
    expect(User.last.first_name).to eq('Jeff')
    expect(User.last.last_name).to eq('Casimir')
    expect(User.last.email).to eq(ENV['MY_EMAIL'])
  end

  scenario 'and does not fill in first name' do
    role = create :role, name: 'Staff'
    invite = create :invitation, role: role

    visit invite.generate_url(new_user_registration_url)

    fill_in 'Last name', with: 'Casimir'
    fill_in 'Email', with: ENV['MY_EMAIL']
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'

    error_message = "First name can't be blank"

    expect(page).to have_content(error_message)
    expect(User.count).to eq(0)
  end
end
