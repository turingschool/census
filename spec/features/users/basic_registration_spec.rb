require 'rails_helper'

RSpec.feature 'User signs up' do
  scenario 'by completing minimum registration' do
    role = create :role, name: 'admin'
    invite = create :invitation, role: role

    visit invite.generate_url(new_user_registration_url)

    fill_in 'First Name*', with: 'Jeff'
    fill_in 'Last Name*', with: 'Casimir'
    fill_in 'Password*', with: 'password'
    fill_in 'Password Confirmation*', with: 'password'

    click_button 'Sign up'

    help_message = 'You have succesfully signed up!'

    expect(page).to have_content(help_message)
    expect(User.count).to eq(1)
    expect(User.last.first_name).to eq('Jeff')
    expect(User.last.last_name).to eq('Casimir')
  end

  scenario 'and does not fill in first name' do
    role = create :role, name: 'Staff'
    invite = create :invitation, role: role

    visit invite.generate_url(new_user_registration_url)

    fill_in 'Last Name*', with: 'Casimir'
    fill_in 'Password*', with: 'password'
    fill_in 'Password Confirmation*', with: 'password'
    click_button 'Sign up'

    error_message = "First name can't be blank"

    expect(page).to have_content(error_message)
    expect(User.count).to eq(0)
  end

  scenario 'they see all input fields' do
    role = create :role, name: 'Staff'
    invite = create :invitation, role: role

    visit invite.generate_url(new_user_registration_url)

    expect(page).to have_content("Gender Pronoun(s)")
    expect(page.find_field("gender_pronouns-field")).to be_truthy

    expect(page).to have_content("Twitter")
    expect(page.find_field("twitter-field")).to be_truthy

    expect(page).to have_content("LinkedIn")
    expect(page.find_field("linkedin-field")).to be_truthy

    expect(page).to have_content("GitHub")
    expect(page.find_field("github-field")).to be_truthy

    expect(page).to have_content("Slack")
    expect(page.find_field("slack-field")).to be_truthy

    expect(page).to have_content("StackOverflow")
    expect(page.find_field("stack_overflow-field")).to be_truthy

    expect(page).to have_content("Cohort")
    expect(page).to have_content("Upload an image")
  end

  scenario "and enters some pronouns" do
    role = create :role, name: 'Mentor'
    invite = create :invitation, role: role

    visit invite.generate_url(new_user_registration_url)

    fill_in 'First Name*', with: 'Jeff'
    fill_in 'Last Name*', with: 'Casimir'
    fill_in 'Password*', with: 'password'
    fill_in 'Password Confirmation*', with: 'password'
    fill_in 'user[gender_pronouns]', with: 'she/her'
    click_button 'Sign up'

    new_user = User.last
    expect(new_user.first_name).to eq('Jeff')
    expect(new_user.last_name).to eq('Casimir')
    expect(new_user.gender_pronouns).to eq("she/her")
  end

end
