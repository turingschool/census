require 'rails_helper'

RSpec.describe Api::V1::SendGrid::EventsController do
  context "Post request is sent to SendGrid" do
    it "updates status of bounced email" do
      create :invitation, email: "email@example.com", status: "mailed"
      post_body = '[{"event":"bounce", "email":"email@example.com"}]'
      post '/api/v1/sendgrid/events', post_body, { format: 'json' }

      expect(Invitation.first.bounce?).to eq(true)
      expect(response.status).to eq(204)
    end
  end
end
