require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  describe '#create' do
    context 'with an invitee invitation' do
      it 'creates the user with enroll-elligible role' do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        enroll_elligible_role = create(:role, name: Role::ENROLL_ELLIGIBLE_ROLE_NAME)
        invitation = create(:invitation, email: "invited@example.com", role: enroll_elligible_role)

        expect {
          post :create,
          params: {
            user: { 
              email: invitation.email,
              first_name: "invited",
              last_name: "yay",
              password: "foobarbaz",
              password_confirmation: "foobarbaz"
            },
          },
          session: {
            invitation_code: invitation.invitation_code,
          }
        }.to change { invitation.reload.status }.to("accepted")

        expect(User.where(email: invitation.email).first!.roles).to match_array([
          enroll_elligible_role
        ])

        expect(response.status).to eq(302)
      end
    end
  end
end
