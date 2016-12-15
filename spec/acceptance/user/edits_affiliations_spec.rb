require 'rails_helper'

RSpec.feature 'User edits affiliations' do
  scenario 'by completing the my affiliations form' do
    affiliation = create(:affiliation)
    user = affiliation.user
    original_group = affiliation.group
    new_group = create(:group, name: "LGBTTuring")
    login(user)

    click_link "Account Info"
    click_link "Edit affiliations"
    find("##{original_group.id}").set(false)
    find("##{new_group.id}").set(true)
    click_button "Save changes"

    expect(current_path).to eq(user_path(user))
    within "div#affiliations" do
      expect(page).to have_content("LGBTTuring")
      expect(page).to_not have_content(original_group.name)
    end
  end
end
