require 'rails_helper'

RSpec.describe Api::V1::Admin::InvitationsController do
  before :each do
    create :role, name: Role::ENROLL_ELLIGIBLE_ROLE_NAME
  end

  context "Request is sent _without_ authorization credentials" do
    it "returns a 401 (unauthorized) response status" do
      post api_v1_admin_invitations_path

      expect(response).to have_http_status(401)
    end
  end

  context "Request is sent _with_ authorization credentials" do
    it "creates the invitation" do
      user_cohort = Cohort.new(OpenStruct.new(id: 1234, name: "1609-be"))
      user = create :user
      user.roles << Role.find_or_create_by!(name: "admin")
      application = create(
        :application,
        owner: user,
        scopes: Oauth::ApplicationsController::ADMIN_SCOPE_NAME
      )
      token = create(
        :access_token,
        resource_owner_id: user.id,
        application: application,
        scopes: Oauth::ApplicationsController::ADMIN_SCOPE_NAME
      ).token
      invitee_email = "invitee@example.com"

      expect {
        post api_v1_admin_invitations_path, params: {
          access_token: token,
          invitation:  { email: invitee_email }
        }
      }.to change { Invitation.where(email: invitee_email).count }.by(1)

      expect(response.status).to eq 201
      response_body = JSON.parse(response.body)
      expect(response_body["invitation"]["id"]).to eq(Invitation.last.id)
    end
  end
end
