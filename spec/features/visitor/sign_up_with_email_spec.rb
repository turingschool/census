require 'rails_helper'

RSpec.feature "user signs up for census" do
  scenario "by initiating email confirmation" do
    visit new_confirmations_path
    expect(page).to have_css('form')

    fill_in 'First name', with: 'Jeff'
    fill_in 'Last name', with: 'Casimir'
    fill_in 'Email', with: ENV['JESSE_EMAIL']

    click_button 'Send confirmation'

    expect(page).to have_content("A confirmation email has been sent to #{ENV['JESSE_EMAIL']}.")
  end
end
