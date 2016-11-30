require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:email) }

  it "can start to be created with name and email" do
    user_params = { "first_name"=>"Jeff",
                    "last_name"=>"Casimir",
                    "email"=>"#{ENV["JESSE_EMAIL"]}"  }

    user = User.start_to_create(user_params)

    expect(user.first_name).to eq("Jeff")
    expect(user.last_name).to eq("Casimir")
    expect(user.email).to eq(ENV["JESSE_EMAIL"])
    expect(user.token).to eq(Digest::SHA256.hexdigest(user_params["email"]))
    expect(user.save!).to eq(true)
  end
end
