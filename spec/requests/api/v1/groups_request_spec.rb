require "rails_helper"

RSpec.describe "Groups API" do
  context  "PATCH api/v1/groups" do
    it "updates and returns 204" do
      user = create(:user)
      token = create(:access_token, resource_owner_id: user.id).token
      original_group = create(:group)

      headers = {"CONTENT-TYPE" => "application/json"}
      params = {group: {id: original_group.id, name: "UpdatedName"}, access_token: token}.to_json

      patch "/api/v1/groups/#{original_group.id}", params: params, headers: headers

      group = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(group['name']).to eq("UpdatedName")
      expect(group['id']).to eq(original_group.id)
      expect(group['member_count']).to eq(original_group.member_count)
    end

  end

  context "delete /api/v1/groups/:id" do
    it "deletes a group" do
      user = create(:user)
      token = create(:access_token, resource_owner_id: user.id).token
      original_group = create(:group)

      headers = {"CONTENT-TYPE" => "application/json"}
      params = {access_token: token}.to_json

      delete "/api/v1/groups/#{original_group.id}", params: params, headers: headers

      group = JSON.parse(response.body)

      expect(response).to be_successful
      expect(group['id']).to eq(original_group.id)
      expect(group['name']).to eq("#{original_group.name}")
      expect(group['member_count']).to eq(original_group.member_count)
    end
  end
end
