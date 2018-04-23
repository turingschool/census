require 'rails_helper'

RSpec.describe "General Search API" do
  include Warden::Test::Helpers

  context  "GET api/v1/users/search" do
    context 'without an access token' do
      it 'authenticates logged in users' do
        user = create :user
        login_as(user, scope: Devise::Mapping.find_scope!(user))

        get "/api/v1/users/search_all", params: { q: 'foo' }

        expect(response.status).to eq 200
      end

      it 'rejects guest users' do
        get "/api/v1/users/search_all", params: { q: 'foo' }
        expect(response.status).to eq 401
      end
    end

    it "searches by cohort and returns users with first, last and groups" do
      cohort_1 = Cohort.new(RemoteCohort.new(id: 1234, status: "closed", name: "1608-BE"))
      cohort_2 = Cohort.new(RemoteCohort.new(id: 1230, status: "open", name: "1703-FE"))
      stub_cohorts_with([cohort_1, cohort_2])
      users = create_list(:user, 3)
      users.first.cohort_id = cohort_1.id
      users.second.cohort_id = cohort_1.id
      users.third.cohort_id = cohort_2.id
      token = create(:access_token, resource_owner_id: users.first.id).token
      group = create(:group, users: users)

      params = {q: cohort_1.name, access_token: token}
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

    it "returns users matching cohort partial search query" do
      cohort_1 = Cohort.new(RemoteCohort.new(id: 1234, name: "1608"))
      cohort_2 = Cohort.new(RemoteCohort.new(id: 1230, name: "1610"))
      cohort_3 = Cohort.new(RemoteCohort.new(id: 1231, name: "1701"))
      stub_cohorts_with([cohort_1, cohort_2, cohort_3])

      users = create_list(:user, 3)
      users.first.cohort_id = cohort_1.id
      users.second.cohort_id = cohort_2.id
      users.third.cohort_id = cohort_3.id
      group = create(:group, users: users)

      token = create(:access_token, resource_owner_id: users.first.id).token
      params = {q: "16", access_token: token}
      get "/api/v1/users/search_all", params: params

      json_users = JSON.parse(response.body)

      expect(json_users.count).to eq(2)

      first = json_users.any? do |user|
        user["first_name"] == users.first.first_name
        user["first_name"] == users.second.first_name
      end

      expect(first).to be_truthy
    end

    it "searches by role and returns users with first, last and groups" do
      role_1, role_2 = create_list(:role, 2)
      users = create_list(:user, 3)
      users.first.roles << role_1
      users.second.roles << role_1
      users.third.roles << role_2
      group = create(:group, users: users)

      token = create(:access_token, resource_owner_id: users.first.id).token
      params = {q: role_1.name, access_token: token}
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

    it "searches by partial role query" do
      role_1 = create(:role, name: "fakerole")
      role_2 = create(:role, name: "fakerole2")
      role_3 = create(:role, name: "admin")
      users = create_list(:user, 3)
      users.first.roles << role_1
      users.second.roles << role_2
      users.third.roles << role_3
      group = create(:group, users: users)

      token = create(:access_token, resource_owner_id: users.first.id).token
      params = {q: "fakerole", access_token: token}
      get "/api/v1/users/search_all", params: params

      json_users = JSON.parse(response.body)

      expect(json_users.count).to eq(2)

      first = json_users.any? do |user|
        user["first_name"] == users.first.first_name
        user["first_name"] == users.second.first_name
      end

      expect(first).to be_truthy
    end

    it "searches by group and returns users with first, last and groups" do
      group_1, group_2 = create_list(:group, 2)
      users = create_list(:user, 3)
      users.first.groups << group_1
      users.second.groups << group_1
      users.third.groups << group_2

      token = create(:access_token, resource_owner_id: users.first.id).token
      params = {q: group_1.name, access_token: token}
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
      expect(json_users.first["groups"].first).to eq(group_1.name)
    end

    it "searches by partial group" do
      group_1 = create(:group, name: "fakegroup")
      group_2 = create(:group, name: "fakegroup2")
      group_3 = create(:group, name: "Turing Lab")
      users = create_list(:user, 3)
      users.first.groups << group_1
      users.second.groups << group_2
      users.third.groups << group_3

      token = create(:access_token, resource_owner_id: users.first.id).token
      params = {q: "fakegroup", access_token: token}
      get "/api/v1/users/search_all", params: params

      json_users = JSON.parse(response.body)

      expect(json_users.count).to eq(2)

      first = json_users.any? do |user|
        user["first_name"] == users.first.first_name
        user["first_name"] == users.second.first_name

      end

      expect(first).to be_truthy
    end

    it "searches by first_name and returns users with first, last and groups" do
      user_1 = create(:user, first_name: "brad")
      user_2 = create(:user, first_name: "brad")
      user_3 = create(:user, first_name: "ali")
      group = create(:group, users: [user_1, user_2, user_3])

      token = create(:access_token, resource_owner_id: user_1.id).token
      params = {q: "brad", access_token: token}
      get "/api/v1/users/search_all", params: params

      json_users = JSON.parse(response.body)

      expect(json_users.count).to eq(2)

      first = json_users.all? do |user|
        user["first_name"] == "brad"
      end

      last = json_users.any? do |user|
        user["last_name"] == user_1.last_name
      end

      expect(first).to be_truthy
      expect(last).to be_truthy
      expect(json_users.first["groups"].first).to eq(group.name)
    end

    it "searches by partial name" do
      user_1 = create(:user, first_name: "gibberish")
      user_2 = create(:user, last_name: "gibberish")
      user_3 = create(:user, first_name: "brad", last_name: "green")
      group = create(:group, users: [user_1, user_2, user_3])

      token = create(:access_token, resource_owner_id: user_1.id).token
      params = {q: "gibberish", access_token: token}
      get "/api/v1/users/search_all", params: params

      json_users = JSON.parse(response.body)

      expect(json_users.count).to eq(2)

      first = json_users.any? do |user|
        user["first_name"] == user_1.first_name
        user["last_name"] == user_2.last_name

      end

      expect(first).to be_truthy
    end

    it "searches by last_name and returns users with first, last and groups" do
      user_1 = create(:user, last_name: "schlereth")
      user_2 = create(:user, last_name: "schlereth")
      user_3 = create(:user, last_name: "green")
      group = create(:group, users: [user_1, user_2, user_3])

      token = create(:access_token, resource_owner_id: user_1.id).token
      params = {q: "schlereth", access_token: token}
      get "/api/v1/users/search_all", params: params

      json_users = JSON.parse(response.body)

      expect(json_users.count).to eq(2)

      last = json_users.all? do |user|
        user["last_name"] == "schlereth"
      end

      first = json_users.any? do |user|
        user["first_name"] == user_1.first_name
      end

      expect(first).to be_truthy
      expect(last).to be_truthy
      expect(json_users.first["groups"].first).to eq(group.name)
    end
  end

  it "searches by full name returning records for matches of first and last names" do
    user_1 = create(:user, first_name: "first")
    user_2 = create(:user, last_name: "last")
    user_3 = create(:user, first_name: "other")
    group = create(:group, users: [user_1, user_2, user_3])

    token = create(:access_token, resource_owner_id: user_1.id).token
    params = {q: "first last", access_token: token}
    get "/api/v1/users/search_all", params: params

    returned_users = JSON.parse(response.body)

    expect(returned_users.count).to eq(2)

    included = returned_users.any? do |user|
      user['last_name'] || user['first_name'] == "first" || "last"
    end

    expect(included).to be_truthy
  end
end
