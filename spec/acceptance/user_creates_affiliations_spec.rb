require 'rails_helper'

RSpec.feature 'User creates affiliations' do
  scenario 'by completing the my affiliations form' do
    user = create(:user)
    login(user)

    visit new_user_affiliation_path(user)

    find("#armstrong").click
    click_button "Submit"

    expect(current_path).to eq(user_path(user))
    within "div#affiliations" do
      expect(page).to have_content("armstrong")
    end
  end
end
