require 'rails_helper'

RSpec.describe Api::V1::Users::ByNameController do
  it "returns info for users whose names match search criterion" do
    test_root_url = "http://www.example.com/"
    user1 = create :user, first_name: "Dan", last_name: "Broadbent"
    create :user, first_name: "Susi", last_name: "Irwin"
    create :user, first_name: "Nate", last_name: "Anderson"

    get "/api/v1/users/by_name?q=an"
    response_users = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(response_users.count).to eq(2)

    expect(response_users.first["first_name"]).to eq(user1["first_name"])
    expect(response_users.first["last_name"]).to eq(user1["last_name"])
    expect(response_users.first["cohort"]).to eq(user1["cohort"])
    expect(response_users.first["image_url"]).to eq(test_root_url + user1.image.url)
  end
end
