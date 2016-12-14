require 'rails_helper'

RSpec.describe Api::V1::Users::AllController do
  it "returns info for all users" do
    users = create_list(:users, 2)

    get "/api/v1/users/all"
    response_users = JSON.parse(response.body)

    expect(response).to be_success
    expect(response_users.count).to eq(2)
    expect(response_users.first.first_name).to eq(users.first.first_name)
    expect(response_users.first.last_name).to eq(users.first.last_name)
  end
end
