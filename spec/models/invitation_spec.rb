require 'rails_helper'

RSpec.describe Invitation, type: :model do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:status) }
  it { should validate_uniqueness_of(:email) }
  it { should belong_to(:user) }
  it { should belong_to(:role) }

  it "validates emails contain an @" do
    invite = Invitation.new(email: "hello world!", status: 0)
    expect(invite.save).to eq(false)
  end

  it "queues an email to be sent" do
    invitation = create :invitation, status: 0
    invitation.send!

    expect(invitation.mailed?)
  end

  it "creates an invitation code" do
    invitation = create :invitation, created_at: "2016-12-13 22:25:56 UTC"
    invitation.create_invitation_code
    expected_code = "546b2d69463d2bc94b2063a2330f5c85c2dc4f1b4b24d798e83e3419516a4f99"

    expect(invitation.invitation_code).to eq(expected_code)
  end

  it "generates a special url" do
    invitation = create :invitation
    url = invitation.generate_url
    expected = "http://localhost:3000/users/sign_up?invite_code=#{invitation.create_invitation_code}"

    expect(url).to eq(expected)
  end
end
