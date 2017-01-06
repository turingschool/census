require 'rails_helper'
RSpec.describe User, type: :model do
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should have_many(:affiliations).dependent(:destroy) }
  it { should have_many(:groups).through(:affiliations) }
  it { should have_many(:user_roles).dependent(:destroy) }
  it { should have_many(:roles).through(:user_roles) }
  it { should have_many(:invitations) }
  it { should have_many(:oauth_applications) }

  # testing paperclip
  it { should have_attached_file(:image) }
  it { should validate_attachment_content_type(:image).
                allowing('image/png', 'image/gif', 'image/png').
                rejecting('text/plain', 'text/xml') }

  it "has a full name" do
    user = create(:user)
    expect(user.full_name).to eq("#{user.first_name} #{user.last_name}")
  end

  it "can report out its roles" do
    user = create :user_with_roles

    expect(user.list_roles).to eq("dummy_role, dummy_role")
  end

  it "can find specific role associated with it" do
    user = create :user
    role_1 = create :role, name: "enrolled"
    role_2 = create :role, name: "active student"
    user.roles << [role_1, role_2]

    expect(user.has_role?("enrolled")).to_be true
    expect(user.has_role?("active student")).to_be true
    expect(user.has_role?("admin")).to_be false
  end

  it "can return users by name search" do
    dan  = create :user, first_name: "Dan", last_name: "Broadbent"
    susi = create :user, first_name: "Susi", last_name: "Irwin"
    nate = create :user, first_name: "Nate", last_name: "Anderson"

    users = User.search_by_name("an")

    expect(users).to eq([dan, nate])
  end
end
