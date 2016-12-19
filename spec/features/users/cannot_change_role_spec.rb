require 'rails_helper'

RSpec.feature 'Default users cannot change roles' do
  scenario 'visiting the edit profile path' do
    user = create :user
    login(user)
    visit edit_user_registration_path(user)

    expect(page).to_not have_content("Role")
  end
end
