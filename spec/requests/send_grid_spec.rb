require 'rails_helper'

RSpec.describe SendGridController do
  context "Post request is sent to SendGrid" do
    it "updates status of bounced email" do
      post '/sendgrid'

      expect(response).to have_http_status(401)
    end
  end
end
