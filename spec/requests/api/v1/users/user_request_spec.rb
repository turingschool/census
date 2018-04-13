require 'rails_helper'

RSpec.describe Api::V1::CredentialsController do
  context "Request is sent _without_ authorization credentials" do
    it "returns a 401 (unauthorized) JSON response" do
      get api_v1_user_credentials_path

      expect(response).to have_http_status(401)
      expect(JSON.parse(response.body)["errors"]).to match_array(["Not authorized"])
    end
  end
end
