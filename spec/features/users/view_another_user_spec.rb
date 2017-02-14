require 'rails_helper'

RSpec.describe 'User profiles' do
  it 'does not show another user"s information' do
    me = create :enrolled_user
    other = create :user, first_name: 'Andrew', last_name: 'Carmer'

    login me

    visit users_path

    expect(page).to_not have_link("Andrew Carmer")
    expect(page).to have_content("Andrew Carmer")

    visit "/users/#{other.id}/"

    expect(page).to_not have_content("Andrew Carmer")
    expect(page).to have_content("#{me.first_name}")
  end

  it 'prevets another user from editing my infromation' do
    me = create :enrolled_user
    other = create :user, first_name: 'Andrew', last_name: 'Carmer'

    login me

    visit user_path other

    expect(page).to_not have_content("Andrew")

    visit "/users/#{other.id}/edit"

    expect(page).to_not have_content("Andrew")
    expect(page).to have_field("user[first_name]", with: "#{me.first_name}")
  end
end
