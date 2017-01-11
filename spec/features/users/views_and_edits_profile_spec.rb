require 'rails_helper'

RSpec.describe 'User visits edit profile page' do
  it 'has an edit button' do
    me = create :user
    login me
    visit user_path(me)

    expect(page).to have_link('Edit profile')
  end

  it 'has a change password button' do
    me = create :user
    login me
    visit user_path me

    expect(page).to have_link('Change password')
  end

  xscenario "they can edit their information" do
    user = User.create(first_name: "OriginalFirst",
                       last_name:  "OriginalLast",
                       email:      "Original@Email",
                       twitter:    "OriginalTwitter",
                       linked_in:  "OriginalLinkedIn",
                       git_hub:    "OriginalGitHub",
                       slack:      "OriginalSlack",
                       cohort:     "OriginalCohort",
                       password:   "OriginalPassword")
    login user

    visit user_path user
    click_on "Edit profile"
    fill_in "first_name", with: "NewFirst"

    expect(user.first_name).to eq("NewFirst")
    expect(user.last_name).to  eq("NewLast")
    expect(user.email).to      eq("New@Email")
    expect(user.twitter).to    eq("NewTwitter")
    expect(user.linked_in).to  eq("NewLinkedIn")
    expect(user.git_hub).to    eq("NewGitHub")
    expect(user.slack).to      eq("NewSlack")
    expect(user.cohort).to     eq("NewCohort")
    expect(user.password).to   eq("NewPassword")
  end
end
