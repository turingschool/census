require 'rails_helper'

RSpec.describe 'Admin' do
  it 'can change a users role from student to alumni' do
    #   As an admin
    admin = create :admin
    sign_in admin

    student = create :user
    student_role = create :role, name: 'student'
    alumni_role = create :role, name: 'alumni'
    student.roles << student_role
    # When I navigate to a student's page
    visit user_path(student)

    # And I select an alumni role
    click_on 'Graduate'
    # And I select Update
    # Then I land on the same page
    expect(current_path).to eq user_path(student)
    # And the user's status does not show as 'student'
    expect(page).not_to have_content 'student'
    # And the user's status now shows as 'alumni'
    expect(page).to have_content 'alumni'
  end
end
