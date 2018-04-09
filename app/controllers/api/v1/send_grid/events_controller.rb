class Api::V1::SendGrid::EventsController < Api::V1::ApiController
  skip_before_action :doorkeeper_authorize!, only: [:update]

  def update
    webhook_data = JSON.parse(request.body.read)
    webhook_data.each do |data|
      invitation = Invitation.find_by(email: data["email"])
      invitation.status = data["event"] if invitation
      invitation.save
    end
  end
end
