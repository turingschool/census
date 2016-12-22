require 'rails_helper'

RSpec.describe 'Invitations' do
  it 'can be filtered without reloading the page' do
    #as an administrator
    me = create :admin
    login me
    #in order to see filtered lists of invitations
    mentor = create :role, name: 'mentor'
    admin = create :role, name: 'admin'
    5.times do |n|
       create :invitation, email: "thing#{n}@example.com", role: mentor
    end
    5.times do |n|
       create :invitation, email: "stuff#{n}@example.com", role: admin
    end
    #when I go to the invitation dashoard
    visit admin_dashboard_path
    expect(page).to have_content('Cancel', count: 10)
    #and I choose an option from the dropdown
    select('mentor', from: 'role')
    #then I should stay on the same page
    expect(current_path).to eq(admin_dashboard_path) 
    #and the content should change
    expect(page).to have_content('Cancel', count:5)
  end
end
