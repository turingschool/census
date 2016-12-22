require 'rails_helper'

RSpec.describe 'User Profile' do
  it 'has an edit button' do
    me = create :user
    login me
    visit user_path(me)

    expect(page).to have_link('Edit profile')
  end

  it 'has a change password button' do
    me = create :user
    login me
    visit user_path me

    expect(page).to have_link('Change password')
  end
end
