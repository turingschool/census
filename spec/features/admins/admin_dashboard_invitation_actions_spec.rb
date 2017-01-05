require 'rails_helper'

RSpec.feature "admin dashboard inviation actions" do
  it "can resend a pending invitation" do
    admin = create :admin
    invite = create :invitation

    sign_in admin
    visit admin_dashboard_path
    expect(page).to have_content("queued")

    click_link "Resend"

    expect(current_path).to eq(admin_dashboard_path)
    expect(page).to have_content("mailed")
  end

  it "can rescind a pending invitation" do
    admin = create :admin
    invite = create :invitation

    sign_in admin
    visit admin_dashboard_path
    expect(page).to have_content("me@example.com")

    click_link "Cancel"

    expect(current_path).to eq(admin_dashboard_path)
    expect(page).to_not have_content("me@example.com")
  end
end
