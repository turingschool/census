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

      users = JSON.parse(response.body)

      expect(users.count).to eq(2)
      expect(users.include?(users.first.first_name)).to be_truthy
      expect(users.include?(users.third.first_name)).to be_falsey
      expect(users.include?(users.first.last_name)).to be_truthy
      expect(users.include?(users.third.last_name)).to be_falsey
      expect(users.first.group).to eq(group.name)

    end
  end
end
