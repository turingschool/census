require 'rails_helper'

RSpec.describe 'Registered User' do
  it 'cannot manage invites' do
    user = create :user
    sign_in user

    visit invitations_path

    expect(page).to have_content "The page you were looking for doesn't exist."

    visit new_invitation_path

    expect(page).to have_content "The page you were looking for doesn't exist."
  end
end
