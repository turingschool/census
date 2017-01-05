require 'rails_helper'

RSpec.feature 'Uninvited user features' do
  it 'cannot see sign up page' do
    visit new_user_registration_url

    expect(page).to have_content("The page you were looking for doesn't exist.")
  end
end
