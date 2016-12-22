require 'rails_helper'

RSpec.describe 'User profiles' do
  it 'shows another user information' do
    me = create :user
    othe = create :user, first_name: 'Andrew', last_name: 'Carmer'

    login me

    visit users_path

    click_link 'Andrew Carmer'

    expect(page).to have_content("First name Andrew")
  end

  it 'prevets another user from editing my infromation' do
    me = create :user
    other = create :user, first_name: 'Andrew', last_name: 'Carmer'

    login me

    visit user_path other

    expect(page).to have_content('Andrew')
    expect(page).to_not have_link('Edit profile')
  end
end
