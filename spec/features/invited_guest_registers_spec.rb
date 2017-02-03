require 'rails_helper'

RSpec.feature 'Invited user features' do
  it 'cannot change the email' do
    role = create :role, name: 'Mentor'
    invite = create :invitation, role: role

    visit invite.generate_url(new_user_registration_url)

    expect(find('#user_email').readonly?).to eq(true)
  end

  it 'cannot sign up if invitation code is not valid' do
    invite = create :invitation
    visit '/users/sign_up?invite_code=bad_code'

    expect(page).to have_content("The page you were looking for doesn't exist.")
  end

  it 'sees the registration form again if details are missing' do
    role = create :role, name: 'Mentor'
    cohort = create :cohort, name: "1608-BE"
    invite = create :invitation, role: role, cohort: cohort
    invite_path = invite.generate_url(new_user_registration_url)
    visit invite_path

    expect(page).to have_select('user_cohort_id', selected: '1608-BE')

    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    fill_in 'First name', with: 'Jeff'
    click_button 'Sign up'
    expect(current_url).to eq(invite_path)
  end
end
