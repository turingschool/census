require 'rails_helper'

RSpec.feature "user confirms email with minimum user info" do
  scenario "by completing user form" do
    user = FactoryGirl.create(:user)
    visit "users/edit?token=#{user.token}"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Submit"

    within 'tr' do
      expect(page).to have_content("#{user.first_name} #{user.last_name}")
    end
    expect(page).to have_css('tr', count: 2)
  end
end
