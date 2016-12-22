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
end
