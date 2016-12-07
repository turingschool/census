require 'rails_helper'

RSpec.feature 'User creates affiliations' do
  scenario 'by completing the my affiliations form' do
    user = create(:user)
    create(:group)
    create(:group, name: "LGBTTuring")
    login(user)

    click_link "Account Info"
    click_link "Edit affiliations"
    find("#1").set(true)
    click_button "Save changes"

    expect(current_path).to eq(user_path(user))
    within "div#affiliations" do
      expect(page).to have_content("Armstrong")
    end
  end
end
