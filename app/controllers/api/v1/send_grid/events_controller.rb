class Api::V1::SendGrid::EventsController < Api::V1::ApiController
  def update
    byebug
    invitation = Invitation.find_by(email: params[:email])
    invitation.status = params[:event]
  end
end
