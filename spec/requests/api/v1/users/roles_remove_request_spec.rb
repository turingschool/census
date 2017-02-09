require "rails_helper"

RSpec.describe "User Roles API" do
  context  "PATCH api/v1/users/remove_roles" do
    it "updates and returns 200" do
      role_1, role_2 = create_list(:role, 2)
      user_1, user_2 = create_list(:user, 2, roles: [role_1, role_2])

      headers = {"CONTENT-TYPE" => "application/json"}
      params = {roles: [role_2.id], users: [user_1.id, user_2.id]}.to_json

      patch "/api/v1/users/remove_roles", params: params, headers: headers

      users = JSON.parse(response.body)

      roles_not_present = false
      users.each do |user|
        roles_not_present = user['roles'].none? do |role|
          role['id'] == role_2.id
        end
      end

      expect(response).to have_http_status(200)
      expect(roles_not_present).to eq(true)
    end
  end
end
