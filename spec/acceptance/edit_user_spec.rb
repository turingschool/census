require 'rails_helper'

RSpec.feature 'Edit all user attributes' do
  scenario 'by submitting edit user form' do
    user = create(  :user,
                    first_name: "Joe",
                    last_name: "Shmoe",
                    email: "jshmoe@example.com",
                    slack: "joe_slack",
                    cohort: "1606",
                    twitter: "joe_tweet",
                    linked_in: "joe_linked_in",
                    git_hub: "joe_git")

    new_attributes = { first_name: "not_joe",
                       last_name: "not_shmoe",
                       email: "not_jshmoe@example.com",
                       slack: "not_joe_slack",
                       cohort: "not_1606",
                       twitter: "not_joe_tweet",
                       linked_in: "not_joe_linked_in",
                       git_hub: "not_joe_git" }

    login(user)

    visit edit_user_path
    fill_in "First name", with: "not_joe"
    fill_in "Last name", with: "not_shmoe"

  end
end
