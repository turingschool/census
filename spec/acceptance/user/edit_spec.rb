require 'rails_helper'

RSpec.feature 'Edit all user attributes' do
  scenario 'by submitting edit user form' do
    cohort_1 = Cohort.new(OpenStruct.new(id: 1234, status: "open", name: "1608-BE"))
    cohort_2 = Cohort.new(OpenStruct.new(id: 1230, status: "open", name: "1703-FE"))
    allow(Cohort).to receive(:all).and_return([cohort_1, cohort_2])
    user   = create( :enrolled_user,
                     first_name: "Joe",
                     last_name: "Shmoe",
                     email: "jshmoe@example.com",
                     slack: "joe_slack",
                     cohort_id: cohort_1.id,
                     twitter: "joe_tweet",
                     linked_in: "joelinkedin",
                     git_hub: "joe_git",
                     stackoverflow: "http://stackwhatever.com/person")

    new_attributes = { first_name: "not_joe",
                       last_name: "not_shmoe",
                       email: "not_jshmoe@example.com",
                       slack: "not_joe_slack",
                       cohort_id: cohort_2.id,
                       twitter: "not_joe_tweet",
                       linked_in: "notjoelinkedin",
                       git_hub: "not_joe_git",
                       stackoverflow: "http://stackoverflow.com/blah"}

    login(user)
    click_link "My Account"
    click_link "Edit profile"
    fill_in "First Name*", with: new_attributes[:first_name]
    fill_in "Last Name*", with: new_attributes[:last_name]
    fill_in "Email*", with: new_attributes[:email]
    fill_in "user[slack]", with: new_attributes[:slack]
    fill_in "user[twitter]", with: new_attributes[:twitter]
    fill_in "user[linked_in]", with: new_attributes[:linked_in]
    fill_in "user[git_hub]", with: new_attributes[:git_hub]
    fill_in "user[stackoverflow]", with: new_attributes[:stackoverflow]

    click_button "Update"

    expect(current_path).to eq(user_path(user))

    expect(page).to have_content("Update was successful.")
    expect(page).to have_content(new_attributes[:first_name])
    expect(page).to have_content(new_attributes[:last_name])
    expect(page).to have_content(new_attributes[:email])
    expect(page).to have_content(new_attributes[:slack])
    expect(page).to have_content(new_attributes[:twitter])
    expect(page).to have_content(new_attributes[:linked_in])
    expect(page).to have_content(new_attributes[:git_hub])
    expect(page).to have_content(new_attributes[:stackoverflow])
  end
end
