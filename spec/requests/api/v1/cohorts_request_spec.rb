require 'rails_helper'

RSpec.describe Api::V1::CohortsController do
  context "Request is sent _without_ authorization credentials" do
    it "returns a 401 (unauthorized) response status" do
      get api_v1_user_credentials_path

      expect(response).to have_http_status(401)
    end
  end

  context "Request is sent _with_ authorization credentials" do
    it "returns all cohorts" do
      user = create :user
      token = create(:access_token, resource_owner_id: user.id).token
      cohort1, cohort2, cohort3 = create_list(:cohort, 3)

      get '/api/v1/cohorts', params: {access_token: token}
      response_cohorts = JSON.parse(response.body)

      expect(response_cohorts.length).to eq(4)

      res_cohort1 = response_cohorts.any? do |cohort|
        cohort["id"] == cohort1.id
      end

      res_cohort2 = response_cohorts.any? do |cohort|
        cohort["id"] == cohort2.id
      end

      res_cohort3 = response_cohorts.any? do |cohort|
        cohort["id"] == cohort3.id
      end

      res_cohort4 = response_cohorts.any? do |cohort|
        cohort["id"] == user.cohort.id
      end

      expect(res_cohort4).to be_truthy
      expect(res_cohort3).to be_truthy
      expect(res_cohort2).to be_truthy
      expect(res_cohort1).to be_truthy
    end
  end
end
