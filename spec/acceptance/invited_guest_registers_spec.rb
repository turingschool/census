require 'rails_helper'

RSpec.feature 'Invited user' do
  it 'registers an account' do
    role = create :role, name: 'Mentor'
    invite = create :invitation, role: role
    visit invite.generate_url

    expect(find('#user_email').value).to eq('me@example.com')

    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    fill_in 'First name', with: 'Jeff'
    fill_in 'Last name', with: 'Casimir'

    expect { click_button 'Sign up' }.to change { User.count }.by(1)

    user = User.last
    sign_in user
    visit user_path(user.id)

    expect(page).to have_content('Mentor')
  end

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
    expect(current_url).to eq(current_host + invite.generate_url)
  end
end
