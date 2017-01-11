require 'rails_helper'

RSpec.describe 'User visits edit profile page', js: :true do
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

  context "they enter invalid characters for twitter" do
    scenario "that input field turns red" do
      me = create :user
      login me

      visit edit_user_path me

      fill_in "user[twitter]", with: "j3"

      expect(page).to_not have_css(".input-field-error")

      fill_in "user[twitter]", with: "@j3"

      expect(page).to have_css(".input-field-error")
    end
  end
end
