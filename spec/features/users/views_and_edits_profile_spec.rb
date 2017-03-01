require 'rails_helper'

RSpec.describe 'User visits edit profile page', js: :true do
  it 'has an edit button' do
    user = create :enrolled_user
    login user
    visit user_path(user)

    expect(page).to have_link('Edit profile')
  end

  it 'has a change password button' do
    user = create :enrolled_user
    login user
    visit user_path user

    expect(page).to have_link('Change password')
  end

  context "they enter an '@' with their twitter username" do
    scenario "that input field turns red, but it is corrected for them", js: true do
      user = create :enrolled_user, twitter: ""

      login user

      visit edit_user_path user

      fill_in "user[twitter]", with: "j3"

      expect(page).to_not have_css(".input-field-error")

      fill_in "user[twitter]", with: "@j3"

      expect(page).to have_css(".input-field-error")

      click_on "Update"

      expect(user.reload.twitter).to eq("j3")
    end
  end

  context "they enter an invalid twitter username" do
    scenario "the update is rejected" do
      user = create :enrolled_user, twitter: ""
      login user

      visit edit_user_path(user)

      fill_in "user[twitter]", with: "s!xteench@r@ctor"
      click_on "Update"

      expect(user.reload.twitter).to eq("")
      expect(page).to have_text("Twitter is too long (maximum is 15 characters)")
      expect(page).to have_text("Twitter accepts only alphanumeric and underscore characters")
    end
  end

  context "they enter an invalid LinkedIn username" do
    scenario "they are shown a warning and then the update is rejected", js: true do
      user = create :enrolled_user, linked_in: ""

      login user

      visit edit_user_path(user)

      expect(page).to_not have_css(".input-field-error")

      fill_in "user[linked_in]", with: "b@d"

      expect(page).to have_css(".input-field-error")

      click_on "Update"

      expect(user.reload.linked_in).to eq("")
      expect(page).to have_text("Linked in is too short (minimum is 5 characters)")
      expect(page).to have_text("Linked in accepts only alphanumeric characters")
    end
  end
end
