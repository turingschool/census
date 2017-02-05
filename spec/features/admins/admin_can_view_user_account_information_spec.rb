require 'rails_helper'

RSpec.describe 'User profiles' do
  it 'does not show another user"s information' do
    me = create :admin
    other = create :user, first_name: 'Andrew', last_name: 'Carmer'

    login me

    visit users_path

    click_on "Andrew Carmer"

    expect(page).to have_content("Andrew")
    expect(current_path).to eq("/users/#{other.id}")
  end
end
