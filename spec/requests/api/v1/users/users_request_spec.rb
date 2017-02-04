require 'rails_helper'

RSpec.describe Api::V1::UsersController do
  context "Request is sent _without_ authorization credentials" do
    it "returns a 401 (unauthorized) response status" do
      get api_v1_users_path

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
    it "returns info for requested user" do

      test_root_url = "http://www.example.com/"
      user = create(:user)
      token = create(:access_token, resource_owner_id: user.id).token

      get api_v1_user_path(user.id), params: {access_token: token}

      json_user = JSON.parse(response.body)

      expect(response).to have_http_status(200)

      expect(json_user["first_name"]).to eq(user["first_name"])
      expect(json_user["last_name"]).to eq(user["last_name"])
      expect(json_user["cohort"]).to eq(user.cohort.name)
      expect(json_user["image_url"]).to eq(test_root_url + user.image.url)
      expect(json_user["id"]).to eq(user.id)
      expect(json_user["email"]).to eq(user.email)
      expect(json_user["slack"]).to eq(user.slack)
      expect(json_user["twitter"]).to eq(user.twitter)
      expect(json_user["linked_in"]).to eq(user.linked_in)
      expect(json_user["git_hub"]).to eq(user.git_hub)

    end
  end
end
