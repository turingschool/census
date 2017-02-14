require 'rails_helper'

RSpec.feature "Admin user" do
  it "can update the status of a cohort" do

    create :role, name: "active student"
    create :role, name: "graduated"
    create :role, name: "enrolled"
    admin = create :admin
    sign_in admin
    visit(admin_cohorts_path)

    click_on "Start"
    expect(page).to have_link("Finish")
    expect(Cohort.first.status).to eq("active")

    click_on "Finish"
    expect(Cohort.first.status).to eq("finished")
  end
end
