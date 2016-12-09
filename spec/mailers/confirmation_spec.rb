require "rails_helper"

RSpec.describe ConfirmationMailer, type: :mailer do
    before(:all) do
      setup_mailer
      Devise.mailer = 'Devise::Mailer'
      Devise.mailer_sender = 'test@example.com'
    end

    describe "confirmation email" do
      expect(2).to eq(3)

  #   let(:mail) { Notifications.signup }
  #
  #   it "renders the headers" do
  #     expect(mail.subject).to eq("Signup")
  #     expect(mail.to).to eq(["to@example.org"])
  #     expect(mail.from).to eq(["from@example.com"])
  #   end
  #
  #   it "renders the body" do
  #     expect(mail.body.encoded).to match("Hi")
  #   end
  end
end
