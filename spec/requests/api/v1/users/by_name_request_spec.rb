require 'rails_helper'

RSpec.describe Api::V1::Users::ByNameController do
  it "returns info for users whose names match search criterion" do
    # Census API
    # Request:
    # GET ‘/by_name’ { q: ‘ad’ } - we will adapt this to include the authentication header/params you will require
    # ex GET census-site.turing.io/api/v1/by_name?q=ad
    #
    # Response: A json array of User Objects with all their attributes whose name match the query substring
    # i.e select all users whose name includes the substring
    #
    # Assuming there are no other users with ‘ad’ anywhere in the name, the response could be:
    # [{ id: 1, name: “Adam”, …(other attributes)…}, { id: 17, name: “Vader”, … }]    users = create_list(:user, 2)

    user1 = create :user, first_name: "Dan", last_name: "Broadbent"
    create :user, first_name: "Brendan", last_name: "Dillon"
    create :user, first_name: "Susi", last_name: "Irwin"
    create :user, first_name: "Nate", last_name: "Anderson"

    get "/api/v1/users/by_name?q=an"
    response_users = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(response_users.count).to eq(3)

    expect(response_users.first["first_name"]).to eq(user1["first_name"])
    expect(response_users.first["last_name"]).to eq(user1["last_name"])
    expect(response_users.first["cohort"]).to eq(user1["cohort"])
    expect(response_users.first["image_url"]).to eq(user1.image.url)
  end
end
