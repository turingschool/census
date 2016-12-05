require 'rails_helper'

RSpec.feature 'User signs up' do
  scenario 'by completing full registration' do
    user = attributes_for(:user)
    visit root_path
    click_link 'Login'
    click_link 'Sign up'
    fill_in 'First name', with: user[:first_name]
    fill_in 'Last name', with: user[:lsat_name]
    fill_in 'Email', with: user[:email]
    fill_in 'Password', with: user[:password]
    fill_in 'Password confirmation', with: user[:password]
    fill_in 'Twitter', with: user[:twitter]
    fill_in 'LinkedIn', with: user[:linked_in]
    fill_in 'GitHub', with: user[:git_hub]
    fill_in 'Slack', with: user[:slack]
    find("option[value='1606']").select_option
    find("Armstrong").click

    click_button 'Sign up'

    help_message = 'A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.'
    expect(page).to have_content(help_message)
  end
end
