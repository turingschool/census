require 'rails_helper'

RSpec.describe 'User Information' do

  before(:each) do
    @staff = create :staff
    @other = create :user, first_name: "FirstName", last_name: "LastName"
  end

  it 'links from users index' do
    login @staff

    visit users_path

    click_on "#{@other.first_name} #{@other.last_name}"

    expect(page).to have_content("#{@other.first_name}")
    expect(current_path).to eq("/users/#{@other.id}")
  end

  it 'does not see edit users button' do
    login @staff

    visit user_path(@other)

    expect(page).to_not have_link("Edit User")
  end

  it 'cannot visit users/edit' do
    login @staff

    visit edit_user_path(@other)

    name = find_field("First Name").value

    expect(name).to eq("#{@staff.first_name}")

    expect(page).to_not have_content("#{@other.first_name}")
  end

end
