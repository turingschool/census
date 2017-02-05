require 'rails_helper'

RSpec.describe 'User profiles' do
  it 'admin can edit user"s information' do
    me = create :admin
    other = create :user, first_name: 'Andrew', last_name: 'Carmer'

    login me

    visit "users/#{other.id}/edit"

    expect(page).to have_field("user[first_name]", with: "#{other.first_name}")
    expect(page).to have_field("user[last_name]", with: "#{other.last_name}")

    fill_in "user[first_name]", with: "horrible_syntax"
    click_on "Update"

    expect(current_path).to eq("/users/#{other.id}")
    expect(page).to have_content("horrible_syntax")
    expect(page).to_not have_content("Andrew")
  end
end
