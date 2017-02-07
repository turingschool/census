require 'rails_helper'

RSpec.describe InvitationManager do
  before(:each) { create :role, name: "mentor" }
  before(:each) { create :cohort, name: "1608-BE" }

  let(:invitation_params) do
    { email: "bad_email, good@example.com, bad_example.com",
      role: "Mentor" }
  end

  let(:no_space_invitation_params) do
    { email: "this@example.com,that@example.com",
      role: "Mentor" }
  end

  let(:space_before_comma_params) do
    { email: "this@example.com , that@example.com",
      role: "Mentor" }
  end

  let(:one_email_with_comma) do
    { email: "this@example.com,",
      role: "Mentor" }
  end

  let(:good_params) do
    { email: "good@example.com", role: "Mentor" }
  end

  let(:cohort_params) do
    { email: "good@example.com", role: "Mentor", cohort: "1608-BE" }
  end

  let(:user) { create :admin }

  let(:url) { "http://www.example.com/users/sign_up" }

  it "stores good and bad emails" do
    manager = InvitationManager.new(invitation_params, user, url)

    expect(manager.emails).to eq(["bad_email", "good@example.com", "bad_example.com"])
    expect(manager.bad_emails).to eq(["bad_email", "bad_example.com"])
  end

  it "has a status for all good emails and role" do
    manager = InvitationManager.new(good_params, user, url)
    msg = "Your emails are being sent. You will receive a confirmation once this process is complete."

    expect(manager.status_message).to eq(msg)
  end

  it "has a status for bad emails" do
    manager = InvitationManager.new(invitation_params, user, url)
    msg = "1 out of 3 invites sent. Error sending bad_email, bad_example.com."

    expect(manager.status_message).to eq(msg)
  end

  it "works with space before comma" do
    manager = InvitationManager.new(space_before_comma_params, user, url)
    msg = "Your emails are being sent. You will receive a confirmation once this process is complete."

    expect(manager.status_message).to eq(msg)
  end

  it "works with one email and a comma" do
    manager = InvitationManager.new(one_email_with_comma, user, url)
    msg = "Your emails are being sent. You will receive a confirmation once this process is complete."

    expect(manager.status_message).to eq(msg)
  end

  it "don't need space between emails" do
    manager = InvitationManager.new(no_space_invitation_params, user, url)
    msg = "Your emails are being sent. You will receive a confirmation once this process is complete."

    expect(manager.status_message).to eq(msg)
  end

  it "has a status for no role" do
    params = { email: "good@example.com" }
    manager = InvitationManager.new(params, user, url)
    msg = "Select a role."

    expect(manager.status_message).to eq(msg)
  end

  it "returns an error if bad emails" do
    manager = InvitationManager.new(invitation_params, user, url)

    expect(manager.status).to eq(:error)
    expect(manager.success?).to eq(false)
  end

  it "returns an error if no role" do
    params = { email: "good@example.com" }
    manager = InvitationManager.new(params, user, url)

    expect(manager.status).to eq(:error)
    expect(manager.success?).to eq(false)
  end

  it "returns a notice if all invitations are created" do
    manager = InvitationManager.new(good_params, user, url)

    expect(manager.status).to eq(:notice)
    expect(manager.success?).to eq(true)
  end

  it "adds a role to each invitation" do
    InvitationManager.new(good_params, user, url)
    invite = Invitation.first

    expect(invite.email).to eq("good@example.com")
    expect(invite.role.name).to eq("mentor")
    expect(invite.status).to eq("mailed")
  end

  it "adds a cohort if specified" do
    InvitationManager.new(cohort_params, user, url)
    invite = Invitation.first

    expect(invite.email).to eq("good@example.com")
    expect(invite.role.name).to eq("mentor")
    expect(invite.status).to eq("mailed")
    expect(invite.cohort.name).to eq("1608-BE")
  end
end
