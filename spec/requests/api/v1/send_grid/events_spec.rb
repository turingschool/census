require 'rails_helper'

RSpec.describe Api::V1::SendGrid::EventsController do
  context "Post request is sent to SendGrid" do
    it "updates status of bounced email" do
      invitation = create :invitation, email: "email@example.com", status: "mailed"
      headers = { "CONTENT_TYPE" => "application/json" }
      post_body = JSON.generate(
        {
          "status":"5.0.0",
          "sg_event_id":"sendgrid_internal_event_id",
          "sg_message_id":"sendgrid_internal_message_id",
          "event":"bounce",
          "email":"email@example.com",
          "timestamp":1249948800,
          "smtp-id":"<original-smtp-id@domain.com>",
          "unique_arg_key":"unique_arg_value",
          "category":["category1", "category2"],
          "newsletter":{
            "newsletter_user_list_id":"10557865",
            "newsletter_id": "1943530",
            "newsletter_send_id":"2308608"
          },
          "asm_group_id": 1,
          "reason":"500 No Such User",
          "type":"bounce",
          "ip":"127.0.0.1",
          "tls":"1",
          "cert_err":"0"
        }
      )
      post '/api/v1/sendgrid/events', post_body, headers

      expect(invitation.bounced?).to eq(true)
    end
  end
end
