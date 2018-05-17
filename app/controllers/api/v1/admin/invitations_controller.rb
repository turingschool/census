module Api::V1::Admin
  class InvitationsController < Api::V1::Admin::AdminController
    def create
      manager = InvitationManager.new(
        invitation_params,
        doorkeeper_token.application.owner,
        new_user_registration_url
      )

      if manager.success?
        new_invitation = Invitation.where(email: invitation_params[:email]).first!
        render json: { invitation: { id: new_invitation.id } }, status: 201
      else
        render json: { errors: [manager.status_message] }, status: 422
      end
    end

    private

    def invitation_params
      {
        email: params[:invitation][:email],
        name: params[:invitation][:name],
        role: "Invitee"
      }
    end
  end
end
