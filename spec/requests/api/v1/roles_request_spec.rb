require "rails_helper"

RSpec.describe "Roles API" do
  context  "PATCH api/v1/roles" do
    it "updates and returns 204" do
      user = create(:user)
      token = create(:access_token, resource_owner_id: user.id).token
      role = create(:role)

      headers = {"CONTENT-TYPE" => "application/json"}
      params = {role: {id: role.id, name: "UpdatedName"}, access_token: token}.to_json

      patch "/api/v1/roles/#{role.id}", params: params, headers: headers

      role = JSON.parse(response.body)

      expect(response).to have_http_status(200)
    end

    # it "returns status 400 if role not found" do
    #   user = create(:user)
    #   token = create(:access_token, resource_owner_id: user.id).token
    #   role = create(:role)
    #
    #   headers = {"CONTENT-TYPE" => "application/json"}
    #   params = {role: {id: 275, name: "UpdatedName"}, access_token: token}.to_json
    #
    #   patch "/api/v1/roles/#{275}", params: params, headers: headers
    #
    #   role = JSON.parse(response.body)
    #
    #   expect(response).to have_http_status(400)
    #
    # end
  end
end
