require 'rails_helper'

RSpec.describe 'User signs up' do
  scenario 'by completing minimum registration' do
    visit root_path
    click_link 'Login'
    click_link 'Create account'
    fill_in 'First name', with: 'Jeff'
    fill_in 'Last name', with: 'Casimir'
    fill_in 'Email', with: ENV['MY_EMAIL']
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Create account'

    help_message = 'To complete sign up check your email for instructions.'
    expect(page).to have_content(help_message)
  end
end
