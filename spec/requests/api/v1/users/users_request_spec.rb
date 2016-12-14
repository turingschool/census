require 'rails_helper'

RSpec.describe Api::V1::UsersController do
  it "returns info for all users" do
    users = create_list(:user, 2)

    get "/api/v1/users"
    response_users = JSON.parse(response.body)

    expect(response).to be_success
    expect(response_users.count).to eq(2)

    expect(response_users.first["first_name"]).to eq(users.first["first_name"])
    expect(response_users.first["last_name"]).to eq(users.first["last_name"])
    expect(response_users.first["email"]).to eq(users.first["email"])
    expect(response_users.first["image"]).to eq(users.first["image"])

    expect(response_users.last["first_name"]).to eq(users.last["first_name"])
    expect(response_users.last["last_name"]).to eq(users.last["last_name"])
    expect(response_users.last["email"]).to eq(users.last["email"])
    expect(response_users.last["image"]).to eq(users.last["image"])
  end
end
