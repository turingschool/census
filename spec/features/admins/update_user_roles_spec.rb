require 'rails_helper'

RSpec.describe 'Admin' do
  it 'can change a users role from student to graduated' do
    #   As an admin
    admin = create :admin
    sign_in admin

    student = create :user
    student_role = create :role, name: 'active student'
    graduated_role = create :role, name: 'graduated'
    student.roles << student_role
    # When I navigate to a student's page
    visit user_path(student)

    # And I select an graduated role
    # And I select Update
    click_on 'Graduate'
    # Then I land on the same page
    expect(current_path).to eq user_path(student)
    # And the user's status does not show as 'active student'
    expect(page).not_to have_content 'active student'
    # And the user's status now shows as 'graduated'
    expect(page).to have_content 'graduated'
  end

  it 'can change a users role from student to removed' do
    #   As an admin
    admin = create :admin
    sign_in admin

    student = create :user
    student_role = create :role, name: 'active student'
    graduated_role = create :role, name: 'graduated'
    student.roles << student_role
    # When I navigate to a student's page
    visit user_path(student)

    # And I select an graduated role
    # And I select Update
    click_on 'Graduate'
    # Then I land on the same page
    expect(current_path).to eq user_path(student)
    # And the user's status does not show as 'active student'
    expect(page).not_to have_content 'active student'
    # And the user's status now shows as 'graduated'
    expect(page).to have_content 'graduated'
  end

  it 'can change a users role from student to graduated' do
    #   As an admin
    admin = create :admin
    sign_in admin

    student = create :user
    student_role = create :role, name: 'active student'
    graduated_role = create :role, name: 'graduated'
    student.roles << student_role
    # When I navigate to a student's page
    visit user_path(student)

    # And I select an graduated role
    # And I select Update
    click_on 'Graduate'
    # Then I land on the same page
    expect(current_path).to eq user_path(student)
    # And the user's status does not show as 'active student'
    expect(page).not_to have_content 'active student'
    # And the user's status now shows as 'graduated'
    expect(page).to have_content 'graduated'
  end
end
