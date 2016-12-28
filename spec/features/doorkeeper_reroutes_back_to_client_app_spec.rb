require 'rails_helper'

RSpec.describe "OAuth flow from client app" do
  scenario "redirects back to client app affter successful login" do
    user = create(:user)
    application = create(:application, owner: user)
    visit oauth_authorization_path( client_id: application.uid,
                                    redirect_uri: application.redirect_uri,
                                    response_type: "code")

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    expect(current_path).to eq(oauth_authorization_path)
  end

  scenario "renders 404 if the client app is not recognized" do
    user = create(:user)

    visit oauth_authorization_path( client_id: "fake_id",
                                    redirect_uri: "fake_url",
                                    response_type: "code")

    expect(status_code).to eq(403)
  end
end
