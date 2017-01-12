require 'rails_helper'

RSpec.feature 'Uninvited user features' do
  it 'cannot see sign up page' do
    visit new_user_registration_url

    expect(page).to have_content("The page you were looking for doesn't exist.")
  end

  it 'can see login page' do
    visit root_path

    expect(page).to have_content('Login')
  end

  it 'cannot send HTTP parameters' do
    visit new_user_registration_url + "?invite_code=evil-code"

    expect(page).to have_content("The page you were looking for doesn't exist.")
  end
end
