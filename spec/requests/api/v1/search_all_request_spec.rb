require 'rails_helper'

RSpec.describe "General Search API" do
  context  "GET api/v1/users/search" do
    it "searches by cohort and returns users with first, last and groups" do
      cohort_1, cohort_2 = create_list(:cohort, 2)
      users = create_list(:user, 3)
      users.first.cohort = cohort_1
      users.second.cohort = cohort_1
      users.third.cohort = cohort_2
      group = create(:group, users: users)

      params = {q: cohort_1.name}
      get "/api/v1/users/search_all", params: params

      json_users = JSON.parse(response.body)

      expect(json_users.count).to eq(2)

      first = json_users.any? do |user|
        user["first_name"] == users.first.first_name
      end

      last = json_users.any? do |user|
        user["last_name"] == users.first.last_name
      end

      expect(first).to be_truthy
      expect(last).to be_truthy
      expect(json_users.first["groups"].first).to eq(group.name)

    end
  end
  context  "GET api/v1/users/search" do
    it "searches by role and returns users with first, last and groups" do
      role_1, role_2 = create_list(:role, 2)
      users = create_list(:user, 3)
      users.first.roles << role_1
      users.second.roles << role_1
      users.third.roles << role_2
      group = create(:group, users: users)

      params = {q: role_1.name}
      get "/api/v1/users/search_all", params: params

      json_users = JSON.parse(response.body)

      expect(json_users.count).to eq(2)

      first = json_users.any? do |user|
        user["first_name"] == users.first.first_name
      end

      last = json_users.any? do |user|
        user["last_name"] == users.first.last_name
      end

      expect(first).to be_truthy
      expect(last).to be_truthy
      expect(json_users.first["groups"].first).to eq(group.name)

    end
  end
end
