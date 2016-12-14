require 'rails_helper'
#As an unregistered user
#When I visit my unique registration link
#I am taken to the registration form
#And I see my email (non-editable)
#And I fill in my password
#And I click "Register"
#Then I am taken to the user profile page
#And I see my account information
#And I see my group
#And I receive a welcome to Census email


RSpec.feature 'Invited user' do
  it 'registers an account' do
    role = create :role, name: 'Mentor'
    invite = create :invitation, role: role

    visit invite.generate_url

    expect(find_field('Email').value).to eq('me@example.com')
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    fill_in 'First name', with: 'Jeff'
    fill_in 'Last name', with: 'Casimir'

    expect { click_button 'Sign up'}.to change { User.count }.by(1)
    #
    user = User.last
    # user.password = 'password'

    sign_in user
# save_and_open_page
    visit user_path(user.id)
# binding.pry
# save_and_open_page

    expect(page).to have_content('Mentor')

  end

  it 'cannot change the email' do

  end

  it 'cannot sign up if invitation code is not valid' do

  end

  it 'sees the registration form again if details are missing' do

  end
end
