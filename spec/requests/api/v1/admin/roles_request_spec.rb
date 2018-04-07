require "rails_helper"

RSpec.describe "Roles API" do
  include Warden::Test::Helpers

  context "checks for authentication" do
    # context 'without an access token' do
      it "authenticates logged in admin users" do
        admin = create(:admin)
        role = create(:role)
        login_as(admin, scope: Devise::Mapping.find_scope!(admin))
        headers = {"CONTENT-TYPE" => "application/json"}
        params = {role: {id: role.id, name: "UpdatedName"}}.to_json

        patch "/api/v1/admin/roles/#{role.id}", params: params, headers: headers

        expect(response.status).to eq 200
      end

      it 'rejects logged in users' do
        user = create(:user)
        role = create(:role)
        login_as(user, scope: Devise::Mapping.find_scope!(user))
        headers = {"CONTENT-TYPE" => "application/json"}
        params = {role: {id: role.id, name: "UpdatedName"}}.to_json

        patch "/api/v1/admin/roles/#{role.id}", params: params, headers: headers

        expect(response.status).to eq 401
      end

      it 'rejects guest users' do
        role = create(:role)
        headers = {"CONTENT-TYPE" => "application/json"}
        params = {role: {id: role.id, name: "UpdatedName"}}.to_json

        patch "/api/v1/admin/roles/#{role.id}", params: params, headers: headers

        expect(response.status).to eq 401
      end

  end

  context  "PATCH api/v1/roles" do
    it "updates and returns 204" do
      user = create(:user)
      token = create(:access_token, resource_owner_id: user.id).token
      role = create(:role)

      headers = {"CONTENT-TYPE" => "application/json"}
      params = {role: {id: role.id, name: "UpdatedName"}, access_token: token}.to_json

      patch "/api/v1/admin/roles/#{role.id}", params: params, headers: headers

      role = JSON.parse(response.body)

      expect(response).to have_http_status(200)
    end

    # it "returns status 400 if role not found" do
    #   user = create(:user)
    #   token = create(:access_token, resource_owner_id: user.id).token
    #   role = create(:role)
    #
    #   headers = {"CONTENT-TYPE" => "application/json"}
    #   params = {role: {id: role.id, first_name: "UpdatedName"}, access_token: token}.to_json
    #
    #   patch "/api/v1/roles/#{role.id}", params: params, headers: headers
    #
    #   role = JSON.parse(response.body)
    #
    #   expect(response).to have_http_status(400)
    #
    # end
  end

  context "delete /api/v1/roles/:id" do
    it "deletes a role" do
      user = create(:user)
      token = create(:access_token, resource_owner_id: user.id).token
      role = create(:role)

      headers = {"CONTENT-TYPE" => "application/json"}
      params = {access_token: token}.to_json

      delete "/api/v1/admin/roles/#{role.id}", params: params, headers: headers

      role = JSON.parse(response.body)

      expect(response).to be_success
    end
  end
end
