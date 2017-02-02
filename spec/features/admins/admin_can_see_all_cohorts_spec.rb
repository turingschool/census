require 'rails_helper'

RSpec.feature "Admin user" do
  it "can see all cohorts already created" do
    admin = create :admin
    cohort_1 = create :cohort, name: "1606-be"
    cohort_2 = create :cohort, name: "1606-fe"
    cohort_3 = create :cohort, name: "1608-be"

    sign_in admin
    visit admin_dashboard_path
    click_on "View Cohorts"
    expect(current_path).to eq(admin_cohorts_path)
    within('#active-cohorts') do
      expect(page).to have_content("1606-be")
      expect(page).to have_content("1606-fe")
      expect(page).to have_content("1608-be")
    end
  end
end
