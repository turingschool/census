require 'rails_helper'

RSpec.describe "OAuth flow from client app" do
  scenario "redirects back to client app affter successful login" do
    application = create(:oauth_application)
    # oauth = {
    #   client_id: application.uid,
    #   redirect_uri: application.redirect_uri,
    #   response_type: "code"
    # }

    # allow_any_instance_of(ApplicationController).to receive(:client_id).and_return(true)

    user = create(:user)
    visit oauth_authorization_path( client_id: application.uid,
                                    redirect_uri: application.redirect_uri,
                                    response_type: "code")
    # visit oauth_authorization_path
    # visit "/oauth/applications?client_id=#{application.uid}&redirect_uri=#{application.redirect_uri}&response_type=code"

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    expect(current_path).to eq(oauth_authorization_path)
    # click_button "Authorize"
    #
    # expect(current_path).to eq(application.redirect_uri)
  end

  scenario "renders 404 if the client app is not recognized" do
    user = create(:user)

    visit oauth_authorization_path( client_id: "fake_id",
                                    redirect_uri: "fake_url",
                                    response_type: "code")

    expect(status_code).to eq(403)
  end


end
