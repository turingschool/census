# As a visitor,
# When I visit the app
# I see a form
# And I enter my name
# And I enter my email
# And I click 'send confirmation'
#
# Then I see a confirmation message
# And I receive an email with a confirmation link.
require 'rails_helper'

RSpec.feature "user signs up for census" do
  scenario "by initiating email confirmation" do
    visit initialize_path
    expect(page).to have_css('form')

    fill_in 'First name', with: 'Jeff'
    fill_in 'Last name', with: 'Casimir'
    fill_in 'Email', with: ENV['JESSE_EMAIL']

    click_button 'Submit'

    expect(page).to have_content("A confirmation email has been sent to #{ENV['JESSE_EMAIL']}.")
  end
end
