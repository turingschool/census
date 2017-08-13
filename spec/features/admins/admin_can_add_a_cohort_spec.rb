require 'rails_helper'

RSpec.feature "Admin user" do
  it "can update the status of a cohort" do
    admin = create :admin
    sign_in admin
    visit(admin_cohorts_path)

    expect(page).to_not have_content("1602")

    click_on "+ Add Cohort"
    fill_in 'cohort[name]', with: "1602"
    click_on "Add New Cohort"

    expect(page).to have_content("1602")
  end
end
