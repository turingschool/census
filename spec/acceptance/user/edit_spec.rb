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
                       cohort: "1608",
                       twitter: "not_joe_tweet",
                       linked_in: "not_joe_linked_in",
                       git_hub: "not_joe_git" }

    login(user)
    click_link "Account Info"
    click_link "Edit profile"
    fill_in "First name", with: new_attributes[:first_name]
    fill_in "Last name", with: new_attributes[:last_name]
    fill_in "Email", with: new_attributes[:email]
    fill_in "Slack", with: new_attributes[:slack]
    find("option[value='#{new_attributes[:cohort]}']").select_option
    fill_in "Twitter", with: new_attributes[:twitter]
    fill_in "LinkedIn", with: new_attributes[:linked_in]
    fill_in "GitHub", with: new_attributes[:git_hub]
    click_button "Update"

    expect(current_path).to eq(user_path(user))

    expect(page).to have_content("Update was successful.")
    expect(page).to have_content(new_attributes[:first_name])
    expect(page).to have_content(new_attributes[:last_name])
    expect(page).to have_content(new_attributes[:email])
    expect(page).to have_content(new_attributes[:slack])
    expect(page).to have_content(new_attributes[:cohort])
    expect(page).to have_content(new_attributes[:twitter])
    expect(page).to have_content(new_attributes[:linked_in])
    expect(page).to have_content(new_attributes[:git_hub])
  end
end
