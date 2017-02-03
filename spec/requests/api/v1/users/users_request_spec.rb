require 'rails_helper'

RSpec.describe Api::V1::UsersController do
  context "Request is sent _without_ authorization credentials" do
    it "returns a 401 (unauthorized) response status" do
      get "/api/v1/users"

      expect(response).to have_http_status(401)
    end
  end

  context "Request is sent _with_ authorization credentials" do
    it "returns info for all users" do
      test_root_url = "http://www.example.com/"
      users = create_list(:user, 2)
      token = create(:access_token, resource_owner_id: users.first.id).token

      get api_v1_users_path, params: {access_token: token}
      response_users = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(response_users.count).to eq(2)

      expect(response_users.first["first_name"]).to eq(users.first["first_name"])
      expect(response_users.first["last_name"]).to eq(users.first["last_name"])
      expect(response_users.first["cohort"]["id"]).to eq(users.first["cohort_id"])
      expect(response_users.first["image_url"]).to eq(test_root_url + users.first.image.url)
      expect(response_users.first["id"]).to eq(users.first.id)

      expect(response_users.last["first_name"]).to eq(users.last["first_name"])
      expect(response_users.last["last_name"]).to eq(users.last["last_name"])
      expect(response_users.last["cohort"]["id"]).to eq(users.last["cohort_id"])
      expect(response_users.last["image_url"]).to eq(test_root_url + users.last.image.url)
      expect(response_users.last["id"]).to eq(users.last.id)
    end
  end
  context "Request for user by id is sent _with_ authorization credentials" do
    it "returns info for all users" do
      test_root_url = "http://www.example.com/"
      users = create_list(:user, 2)
      token = create(:access_token, resource_owner_id: users.first.id).token

      get "/api/v1/users/#{users.first.id}", params: {access_token: token}
      user = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(user.count).to eq(1)

      expect(user["first_name"]).to eq(users.first["first_name"])
      expect(user["last_name"]).to eq(users.first["last_name"])
      expect(user["cohort"]["id"]).to eq(users.first["cohort_id"])
      expect(user["image_url"]).to eq(test_root_url + users.first.image.url)
      expect(user["id"]).to eq(users.first.id)

    end
  end
end
