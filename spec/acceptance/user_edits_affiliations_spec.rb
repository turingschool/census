require 'rails_helper'

RSpec.feature 'User edits affiliations' do
  scenario 'by completing the my affiliations form' do
    user = create(:user)
    create(:group)
    create(:group, name: "LGBTTuring")
    create(:affiliation, group: group, user: user)
    login(user)

    click_link "Account Info"
    click_link "Edit affiliations"
    find("#1").set(false)
    find("#2").set(true)
    click_button "Save changes"

    expect(current_path).to eq(user_path(user))
    within "div#affiliations" do
      expect(page).to have_content("LGBTTuring")
    end
  end
end
