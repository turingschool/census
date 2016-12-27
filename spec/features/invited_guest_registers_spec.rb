require 'rails_helper'

RSpec.feature 'Invited user features' do
  it 'cannot change the email' do
    role = create :role, name: 'Mentor'
    invite = create :invitation, role: role

    visit invite.generate_url

    expect(find('#user_email').readonly?).to eq(true)
  end

  it 'cannot sign up if invitation code is not valid' do
    invite = create :invitation
    visit '/users/sign_up?invite_code=bad_code'

    expect(page).to have_content("The page you were looking for doesn't exist.")
  end

  it 'sees the registration form again if details are missing' do
    role = create :role, name: 'Mentor'
    invite = create :invitation, role: role
    visit invite.generate_url

    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    fill_in 'First name', with: 'Jeff'
    click_button 'Sign up'
    expect(current_url).to eq(invite.generate_url)
  end
end
