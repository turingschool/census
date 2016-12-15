require 'rails_helper'

RSpec.describe InvitationManager do
  before(:each) { create :role, name: "mentor" }

  let(:invitation_params) do
    { email: "bad_email, good@example.com, bad_example.com",
      role: "mentor" }
  end

  let(:good_params) do
    { email: "good@example.com", role: "mentor" }
  end

  let(:user) { create :admin }

  it "stores good and bad emails" do
    manager = InvitationManager.new(invitation_params, user)

    expect(manager.emails).to eq(["bad_email", "good@example.com", "bad_example.com"])
    expect(manager.bad_emails).to eq(["bad_email", "bad_example.com"])
  end

  it "has a status for all good emails and role" do
    manager = InvitationManager.new(good_params, user)
    msg = "Your emails are being sent. You will receive a confirmation once this process is complete."

    expect(manager.status_message).to eq(msg)
  end

  it "has a status for bad emails" do
    manager = InvitationManager.new(invitation_params, user)
    msg = "1 out of 3 invites sent. Error sending bad_email, bad_example.com."

    expect(manager.status_message).to eq(msg)
  end

  it "has a status for no role" do
    params = { email: "good@example.com" }
    manager = InvitationManager.new(params, user)
    msg = "Select a role."

    expect(manager.status_message).to eq(msg)
  end

  it "returns an error if bad emails" do
    manager = InvitationManager.new(invitation_params, user)

    expect(manager.status).to eq(:error)
    expect(manager.success?).to eq(false)
  end

  it "returns an error if no role" do
    params = { email: "good@example.com" }
    manager = InvitationManager.new(params, user)

    expect(manager.status).to eq(:error)
    expect(manager.success?).to eq(false)
  end

  it "returns a notice if all invitations are created" do
    manager = InvitationManager.new(good_params, user)

    expect(manager.status).to eq(:notice)
    expect(manager.success?).to eq(true)
  end

  it "adds a role to each invitation" do
    InvitationManager.new(good_params, user)
    invite = Invitation.first

    expect(invite.email).to eq("good@example.com")
    expect(invite.role.name).to eq("mentor")
    expect(invite.status).to eq("mailed")
  end
end
