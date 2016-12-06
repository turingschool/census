require 'rails_helper'

RSpec.feature 'User creates affiliations' do
  scenario 'by completing the my affiliations form' do
    user = create(:user)
    create(:group)
    login(user)

    visit new_affiliation_path
    save_and_open_page
    find("#affiliation_armstrong").click
    click_button "Submit"

    expect(current_path).to eq(user_path(user))
    within "div#affiliations" do
      expect(page).to have_content("armstrong")
    end
  end
end
