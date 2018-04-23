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
      user_cohort = Cohort.new(RemoteCohort.new(id: 1234, name: "1609-be"))
      user = create :user
      token = create(:access_token, resource_owner_id: user.id).token
      cohort_1 = Cohort.new(RemoteCohort.new(id: 1232, name: "1606-be"))
      cohort_2 = Cohort.new(RemoteCohort.new(id: 1230, name: "1606-fe"))
      cohort_3 = Cohort.new(RemoteCohort.new(id: 1231, name: "1608-be"))
      stub_cohorts_with([user_cohort, cohort_1, cohort_2, cohort_3])

      get '/api/v1/cohorts', params: {access_token: token}
      response_cohorts = JSON.parse(response.body)

      expect(response_cohorts.length).to eq(4)

      res_cohort1 = response_cohorts.any? do |cohort|
        cohort["id"] == cohort_1.id
      end

      res_cohort2 = response_cohorts.any? do |cohort|
        cohort["id"] == cohort_2.id
      end

      res_cohort3 = response_cohorts.any? do |cohort|
        cohort["id"] == cohort_3.id
      end

      res_user_cohort = response_cohorts.any? do |cohort|
        cohort["id"] == user.cohort.id
      end

      expect(user_cohort).to be_truthy
      expect(res_cohort3).to be_truthy
      expect(res_cohort2).to be_truthy
      expect(res_cohort1).to be_truthy
    end
  end
end
