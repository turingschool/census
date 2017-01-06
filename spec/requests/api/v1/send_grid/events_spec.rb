require 'rails_helper'

RSpec.describe Api::V1::SendGrid::EventsController do
  context "Post request is sent to SendGrid" do
    it "updates status of bounced email" do
      invitation = create :invitation, email: "email@example.com", status: "mailed"
      headers = { "CONTENT_TYPE" => "application/json" }
      post_body = JSON.generate([{"event":"bounce", "email":"email@example.com"}])
      post '/api/v1/sendgrid/events', post_body

      expect(invitation.bounced?).to eq(true)
      expect(response.status).to eq(200)
    end
  end
end
