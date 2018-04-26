require "rails_helper"

RSpec.describe "Roles API" do
  context  "PATCH api/v1/admin/roles/:id" do
    it "updates and returns 200" do
      user = create(:user)
      token = create(:access_token, resource_owner_id: user.id, scopes: "admin").token
      role = create(:role)

      headers = {"CONTENT-TYPE" => "application/json"}
      params = {role: {id: role.id, name: "UpdatedName"}, access_token: token}.to_json

      patch "/api/v1/admin/roles/#{role.id}", params: params, headers: headers

      role = JSON.parse(response.body)

      expect(response).to have_http_status(200)
    end
  end

  context "delete /api/v1/admin/roles/:id" do
    it "deletes a role" do
      user = create(:user)
      token = create(:access_token, resource_owner_id: user.id, scopes: "admin").token
      role = create(:role)

      headers = {"CONTENT-TYPE" => "application/json"}
      params = {access_token: token}.to_json

      delete "/api/v1/admin/roles/#{role.id}", params: params, headers: headers

      role = JSON.parse(response.body)

      expect(response).to have_http_status(200)
    end
  end
end
