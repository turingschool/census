require 'rails_helper'
RSpec.describe User, type: :model do
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should have_many(:affiliations).dependent(:destroy) }
  it { should have_many(:groups).through(:affiliations) }
  it { should have_many(:user_roles).dependent(:destroy) }
  it { should have_many(:roles).through(:user_roles) }
  it { should have_many(:invitations) }

  it "has a full name" do
    user = create(:user)
    expect(user.full_name).to eq("#{user.first_name} #{user.last_name}")
  end

  it "can report out its roles" do
    user = create :user_with_roles

    expect(user.list_roles).to eq("dummy_role, dummy_role")
  end
end
