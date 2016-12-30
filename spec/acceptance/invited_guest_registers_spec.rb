require 'rails_helper'

RSpec.feature 'Invited user' do
  it 'registers an account' do
    role = create :role, name: 'Mentor'
    invite = create :invitation, role: role
    visit invite.generate_url(new_user_registration_url)

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
end
