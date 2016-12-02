require 'rails_helper'

RSpec.feature 'User signs up' do
  scenario 'by completing minimum registration' do
    visit root_path
    click_link 'Login'
    click_link 'Sign up'
    fill_in 'First name', with: 'Jeff'
    fill_in 'Last name', with: 'Casimir'
    fill_in 'Email', with: ENV['MY_EMAIL']
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'

    help_message = 'A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.'

    expect(page).to have_content(help_message)
    expect(User.count).to eq(1)
    expect(User.last.first_name).to eq('Jeff')
    expect(User.last.last_name).to eq('Casimir')
    expect(User.last.email).to eq(ENV['MY_EMAIL'])
    expect(User.last.password).to eq('password')
    expect(User.last.password_confirmation).to eq('password')
  end
end
