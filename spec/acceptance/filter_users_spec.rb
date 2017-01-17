require 'rails_helper'

RSpec.feature 'Filter users by cohort' do
  scenario 'by selecting cohort from dropdown' do
    cohort = create(:cohort)
    create(:user, cohort_id: cohort.id)
    user = create(:user, cohort_id: cohort.id)

    login(user)

    save_and_open_page

    expect(page).to have_css("tr", count: 3)
    find("option[value='1606']").select_option
    click_button "Filter"

    expect(page).to have_content("Cohort: 1606")
    expect(page).to have_css("tr", count: 2)
  end
end
