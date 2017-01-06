require 'rails_helper'

RSpec.describe Api::V1::CredentialsController do
  context "Request is sent _without_ authorization credentials" do
    it "returns a 401 (unauthorized) response status" do
      get api_v1_user_path

      expect(response).to have_http_status(401)
    end
  end

  context "Request is sent _with_ authorization credentials" do
    it "returns info for all users" do
      test_root_url = "http://www.example.com/"
      user = create :user
      token = create(:access_token, resource_owner_id: user.id).token

      get api_v1_user_path, params: {access_token: token}
      response_user = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(response_user["first_name"]).to eq(user["first_name"])
      expect(response_user["last_name"]).to eq(user["last_name"])
      expect(response_user["cohort"]).to eq(user["cohort"])
      expect(response_user["id"]).to eq(user.id)
    end
  end
end
