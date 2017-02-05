require "rails_helper"

RSpec.describe "Groups API" do
  context  "PATCH api/v1/groups" do
    it "updates and returns 204" do
      user = create(:user)
      token = create(:access_token, resource_owner_id: user.id).token
      group = create(:group)

      headers = {"CONTENT-TYPE" => "application/json"}
      params = {group: {id: group.id, name: "UpdatedName"}, access_token: token}.to_json

      patch "/api/v1/roles/#{group.id}", params: params, headers: headers

      role = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(role['name']).to eq("UpdatedName")
      expect(role['id']).to eq("#{group.id}")
    end

  end

  context "delete /api/v1/groups/:id" do
    it "deletes a group" do
      user = create(:user)
      token = create(:access_token, resource_owner_id: user.id).token
      group = create(:group)

      headers = {"CONTENT-TYPE" => "application/json"}
      params = {access_token: token}.to_json

      delete "/api/v1/groups/#{group.id}", params: params, headers: headers

      role = JSON.parse(response.body)

      expect(response).to be_success
      expect(role['id']).to eq("#{group.id}")
      expect(role['name']).to eq("#{group.name}")
    end
  end
end
