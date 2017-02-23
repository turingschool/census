require 'rails_helper'

RSpec.describe Api::V1::Users::ByCohortController do
  context "Request is sent _without_ authorization credentials" do
    it "returns a 401 (unauthorized) response status" do
      get "/api/v1/users/by_cohort?cohort_id=13"

      expect(response).to have_http_status(401)
    end
  end

  context "Request is sent _with_ authorization credentials" do
    it "returns info for users who belong to cohort" do
      test_root_url = "http://www.example.com/"
      cohort = create(:cohort)
      user1 = create :user, first_name: "Dan", last_name: "Broadbent", cohort: cohort
      user2 = create :user, first_name: "Susi", last_name: "Irwin", cohort: cohort
      user3 = create :user, first_name: "Nate", last_name: "Anderson"
      token = create(:access_token, resource_owner_id: user1.id).token

      get "/api/v1/users/by_cohort?cohort_id=#{cohort.id}", params: {access_token: token}
      response_users = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(response_users.count).to eq(2)

      expect(response_users.length).to eq(2)

      susi = response_users.any? do |user|
        user["first_name"] == "Susi"
      end

      nate = response_users.any? do |user|
        user["first_name"] == "Nate"
      end

      expect(susi).to be_truthy
      expect(nate).to be_falsey
    end
  end
end
