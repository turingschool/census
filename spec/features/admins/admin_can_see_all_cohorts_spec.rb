require 'rails_helper'

RSpec.feature "Admin user" do
  it "can see all cohorts already created" do
    admin = create :admin
    cohort_1 = Cohort.new(OpenStruct.new(id: 1234, name: "1606-be"))
    cohort_2 = Cohort.new(OpenStruct.new(id: 1230, name: "1606-fe"))
    cohort_3 = Cohort.new(OpenStruct.new(id: 1231, name: "1608-be"))
    stub_cohorts_with([cohort_1, cohort_2, cohort_3])

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
