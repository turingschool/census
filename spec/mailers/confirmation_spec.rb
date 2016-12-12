require "rails_helper"

RSpec.describe ConfirmationMailer, type: :mailer do
  before do
    ActionMailer::Base.deliveries = []
    Devise.mailer = 'Devise::Mailer'
# change this address?
    Devise.mailer_sender = 'test@example.com'
  end

  after do
    Devise.mailer = 'Devise::Mailer'
# change this address?
    Devise.mailer_sender = 'please-change-me@config-initializers-devise.com'
  end

  def user
    @user ||= User.create!(attributes_for(:user))
  end

  def mail
    @mail ||= begin
      user
      ActionMailer::Base.deliveries.first
    end
  end

  # let(:mail) { ActionMailer::Base.deliveries.first }

  it "sends email after creating the user" do
    expect(mail).to_not eq(nil)

    # expect(mail.subject).to eq("Signup")
    # expect(mail.to).to eq(["to@example.org"])
    # expect(mail.from).to eq(["from@example.com"])
  end
end
