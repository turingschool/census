require 'rails_helper'

RSpec.feature 'User signs up' do
  scenario 'by completing minimum registration' do
    visit root_path
    click_link 'Sign up'
    fill_in 'First name', with: 'Jeff'
    fill_in 'Last name', with: 'Casimir'
    fill_in 'Email', with: ENV['MY_EMAIL']
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'

    help_message = 'A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.'
    expect(page).to have_content(help_message)
  end
end
