require "rails_helper"

RSpec.describe "Groups API" do
  include Warden::Test::Helpers

  context  "PATCH api/v1/groups" do
    context "checks for authentication" do
      it "authenticates logged in admin users" do
        admin = create(:admin)
        login_as(admin, scope: Devise::Mapping.find_scope!(admin))
        original_group = create(:group)

        headers = {"CONTENT-TYPE" => "application/json"}
        params = {group: {id: original_group.id, name: "UpdatedName"}}.to_json

        patch "/api/v1/admin/groups/#{original_group.id}", params: params, headers: headers

        expect(response.status).to eq 200
      end

      it 'rejects logged in users' do
        user = create(:user)
        login_as(user, scope: Devise::Mapping.find_scope!(user))
        original_group = create(:group)

        headers = {"CONTENT-TYPE" => "application/json"}
        params = {group: {id: original_group.id, name: "UpdatedName"}}.to_json

        patch "/api/v1/admin/groups/#{original_group.id}", params: params, headers: headers

        expect(response.status).to eq 401
      end

      it 'rejects guest users' do
        original_group = create(:group)

        headers = {"CONTENT-TYPE" => "application/json"}
        params = {group: {id: original_group.id, name: "UpdatedName"}}.to_json

        patch "/api/v1/admin/groups/#{original_group.id}", params: params, headers: headers

        expect(response.status).to eq 401
      end
    end

    it "updates and returns 204" do
      user = create(:user)
      token = create(:access_token, resource_owner_id: user.id).token
      original_group = create(:group)

      headers = {"CONTENT-TYPE" => "application/json"}
      params = {group: {id: original_group.id, name: "UpdatedName"}, access_token: token}.to_json

      patch "/api/v1/admin/groups/#{original_group.id}", params: params, headers: headers

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

      delete "/api/v1/admin/groups/#{original_group.id}", params: params, headers: headers

      group = JSON.parse(response.body)

      expect(response).to be_success
      expect(group['id']).to eq(original_group.id)
      expect(group['name']).to eq("#{original_group.name}")
      expect(group['member_count']).to eq(original_group.member_count)
    end
  end
end
