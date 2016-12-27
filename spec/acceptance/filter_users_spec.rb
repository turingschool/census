require 'rails_helper'

RSpec.feature 'Filter users by cohort' do
  scenario 'by selecting cohort from dropdown' do
    create(:user, cohort: "1605")
    user = create(:user, cohort: "1606")

    login(user)

    expect(page).to have_css("tr", count: 3)
    find("option[value='1606']").select_option
    click_button "Filter"

    expect(page).to have_content("Cohort: 1606")
    expect(page).to have_css("tr", count: 2)
  end
end
